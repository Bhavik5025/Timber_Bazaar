import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:wood_stockpile/Login%20&%20registration/waiting_screen.dart';
import 'package:wood_stockpile/Login%20&%20registration/widget/image_picker.dart';
import 'package:wood_stockpile/Login%20&%20registration/widget/pic_images.dart';

final _firebase = FirebaseAuth.instance;

class wood_seller_registration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _wood_seller_registration();
  }
}

class _wood_seller_registration extends State<wood_seller_registration> {
  var company_name = "";
  TextEditingController _controller = TextEditingController();
  var phone = "";
  var address = "";
  var pd = "";
  var lat;
  var long;
  var password = "";
  var confirm_password = "";
  var email = "";
  var temp = "";
  var gettinglocation = false;
  var highlight = false;
  var highlight1 = false;
  var isupload = false;
  var register = false;
  final _formkey = GlobalKey<FormState>();
  XFile? selectedimage;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<String> downloadurl = [];
  bool gettingLocation = false;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    Location location = Location();

    try {
      bool _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          // Handle the case when the user doesn't enable location services
          return;
        }
      }

      PermissionStatus _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          // Handle the case when the user doesn't grant location permission
          return;
        }
      }

      setState(() {
        gettingLocation = true;
      });

      LocationData _locationData = await location.getLocation();

      setState(() {
        gettingLocation = false;
        lat = _locationData.latitude;
        long = _locationData.longitude;
      });

      print("Latitude: $lat, Longitude: $long");
    } catch (e) {
      // Handle any unexpected errors here
      print("Error getting location: $e");
    }
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      setState(() {});
    }
  }

  void removeImage(int index) {
    setState(() {
      imageFileList.removeAt(index);
    });
  }

  void loc() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      gettinglocation = true;
    });
    _locationData = await location.getLocation();
    setState(() {
      gettinglocation = false;
      lat = _locationData.latitude;
      long = _locationData.longitude;
    });

    final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyAr1dn7Gm4qQzKjgqocTqTCya1g8CKp7ZY');
    var response = await http.get(uri);
    setState(() {
      final gt = jsonDecode(response.body);
      pd = gt['results'][0]['formatted_address'];
      _controller.text = pd;
    });

    print(pd);
  }

  void btn() async {
    final isvalid = _formkey.currentState!.validate();
    if (!isvalid) {
      //show error message....

      return;
    }
    if (selectedimage == null) {
      setState(() {
        highlight = true;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please Upload Your Certificate.')));

      print(highlight);
    } else if (imageFileList.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please add Company Images.')));
      setState(() {
        highlight1 = true;
      });
    } else {
      setState(() {
        highlight = false;
      });
      print(highlight);

      _formkey.currentState!.save();
      try {
        setState(() {
          isupload = true;
        });
        final uc = await _firebase.createUserWithEmailAndPassword(
            email: email, password: password);
        final storageref = FirebaseStorage.instance
            .ref()
            .child('centificate')
            .child('${uc.user!.uid}.jpg');
        //store multiple images
        final FirebaseStorage storage = FirebaseStorage.instance;
        final Reference storageRef =
            storage.ref().child('company_Images').child('${uc.user!.uid}');
        for (int i = 0; i < imageFileList.length; i++) {
          final XFile imageFile = imageFileList[i];
          final String fileName = 'image_$i.jpg'; // Unique name for each image
          final Reference fileRef = storageRef.child(fileName);

          try {
            await fileRef.putFile(File(imageFile.path));
            downloadurl.add(await fileRef.getDownloadURL());
            print("images" + downloadurl[i]);
          } catch (e) {
            print('Error uploading image $i: $e');
          }
        }
        await storageref.putFile(File(selectedimage!.path));
        final imageurl = await storageref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('unverified_wood_seller')
            .doc(uc.user!.uid)
            .set({
          'uid': uc.user!.uid,
          'Company_name': company_name,
          'email': email,
          'Mobile_no': phone,
          'Address': address,
          'Password': password,
          'certificate': imageurl,
          'images': downloadurl,
          'type': 'wood_seller',
          'verified': 'no',
          'latitude': lat,
          'longitude': long
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => waiting_screen()));

        setState(() {
          register = true;
          isupload = false;
        });
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          //...
        }
        print('FirebaseAuthException occurred: ${error.code}');
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'authentication failed.')));
        setState(() {
          isupload = false;
        });
      }
    }
  }

 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 26,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 45),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 237, 235, 235),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Stack(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 90),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Lottie.asset(
                                            "assets/lottie/wood_seller.json",
                                            height: 150),
                                        radius: 110,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                              Form(
                                  key: _formkey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: "Company Name",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().length < 4) {
                                              return "please Enter the Company Name";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            company_name = value!;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: "Mobile No.",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            final RegExp phoneRegex =
                                                RegExp(r'^\d{10}$');

                                            if (!phoneRegex.hasMatch(value!)) {
                                              return 'Please enter a valid 10-digit mobile number';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            phone = value!;
                                          },
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: TextFormField(
                                                maxLines: 3,
                                                controller: _controller,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "Address",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                ),
                                                keyboardType:
                                                    TextInputType.streetAddress,
                                                validator: (value) {
                                                  if (value == "") {
                                                    return "please enter the address";
                                                  }
                                                },
                                                onSaved: (value) {
                                                  address = value!;
                                                },
                                              ),
                                            ),
                                          ),
                                          if (gettinglocation)
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.black),
                                              ),
                                            ),
                                          if (!gettinglocation)
                                            IconButton(
                                                onPressed: loc,
                                                icon: Icon(Icons.location_on)),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                                color: highlight
                                                    ? Colors.red
                                                    : Colors.white),
                                          ),
                                          child: image_picker(
                                              onpicedImage: (pickedImage) =>
                                                  selectedimage = pickedImage),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                              color: highlight1
                                                  ? Colors.red
                                                  : Colors.white,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                                SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: imageFileList
                                                      .map((imageFile) {
                                                    final index = imageFileList
                                                        .indexOf(imageFile);
                                                    return GestureDetector(
                                                      onTap: () {
                                                        removeImage(index);
                                                        // Handle image tap or removal here
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Container(
                                                          width:
                                                              200, // Set the width as needed
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    253,
                                                                    251,
                                                                    251),
                                                                width: 1),
                                                            color: Colors.white,
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(3),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Container(
                                                              height: 300,
                                                              child: Image.file(
                                                                File(imageFile
                                                                    .path),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              ElevatedButton.icon(
                                                onPressed: selectImages,
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .black, // background color
                                                  foregroundColor: Colors.white,
                                                ),
                                                icon: Icon(Icons.upload_file),
                                                label: Text(
                                                    "Select Company Images"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: "Email",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          autocorrect: false,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty ||
                                                !value.contains("@")) {
                                              return "please enter valid email address";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            email = value!;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: "Password",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                          obscureText: true,
                                          validator: (value) {
                                            temp = value!;
                                            print(value);
                                            if (value.isEmpty ||
                                                value.trim().length < 6) {
                                              return "password must be 6 character long";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            password = value!;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: "Confirm password",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                          obscureText: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().length < 6) {
                                              return "password must be 6 character long";
                                            }
                                            if (value != temp) {
                                              print(value);
                                              print(password);
                                              return "password and confirm password are not same";
                                            }

                                            return null;
                                          },
                                          onSaved: (value) {
                                            confirm_password = value!;
                                          },
                                        ),
                                      ),
                                      if (isupload)
                                        const Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.black),
                                          ),
                                        ),
                                      if (!isupload)
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: SizedBox(
                                            width: 170,
                                            height: 50,
                                            child: ElevatedButton(
                                                onPressed: btn,
                                                child: Text(
                                                  "Register",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .black, // background color
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                )),
                                          ),
                                        ),
                                    ],
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
