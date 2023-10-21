import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wood_stockpile/wood_seller_dashboard/homescreen.dart';
import 'package:uuid/uuid.dart';

class furniture_details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _furniture();
  }
}

class _furniture extends State<furniture_details> {
  String productId = Uuid().v4();
  var product_name = "";
  var product_description = "";
  var highlight1 = false;
  var delivery_charge;
  dynamic product_price;
  String imagesId = Uuid().v4();
  var isupload = false;
  List<String> downloadurl = [];
  final _formkey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

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

  void btnclick() async {
    print(product_name);
    print(product_price.toString());
    print(product_description);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('company_email'));
    final isvalid = _formkey.currentState!.validate();
    if (!isvalid) {
      //show error message....

      return;
    }
    if (imageFileList.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please add Product Images.')));
      setState(() {
        highlight1 = true;
      });
    } else {
      setState(() {
        highlight1 = false;
        isupload = true;
      });
      _formkey.currentState!.save();
      try {
        final FirebaseStorage storage = FirebaseStorage.instance;
        final Reference storageRef = storage
            .ref()
            .child('product_Images')
            .child(FirebaseAuth.instance.currentUser!.uid);
        for (int i = 0; i < imageFileList.length; i++) {
          final XFile imageFile = imageFileList[i];
          final String fileName = imagesId; // Unique name for each image
          final Reference fileRef = storageRef.child(fileName);

          try {
            await fileRef.putFile(File(imageFile.path));
            downloadurl.add(await fileRef.getDownloadURL());
            print("images" + downloadurl[i]);
          } catch (e) {
            print('Error uploading image $i: $e');
          }
        }
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .set({
          "Company_email": prefs.getString('company_email'),
          "c_id": FirebaseAuth.instance.currentUser!.uid,
          "pid": productId,
          "product_name": product_name,
          "category": "Furniture",
          "price": product_price,
          "product_description": product_description,
          "product_images": downloadurl,
          "delivery_charge": delivery_charge,
        });
        setState(() {
          isupload = false;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product Upload Successfully')));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => homescreen()),
          );
        });
      } on FirebaseAuthException catch (error) {
        print('FirebaseAuthException occurred: ${error.code}');
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'upload failed.')));
        setState(() {
          isupload = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
      appBar: AppBar(
        title: Text("Wood StockPile"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Add Furniture Details",
                style: TextStyle(fontSize: 24),
              ),
            ),
            SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Product Name",
                              prefixIcon: Icon(Icons.table_bar),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "please enter Product Name";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              product_name = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Product Description",
                              prefixIcon: Icon(Icons.description),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "please enter Product Description";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              product_description = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Product Price",
                              prefixIcon: Icon(Icons.currency_rupee_sharp),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter Product Price";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              product_price = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Delivery charge per Kilometer",
                              prefixIcon: Icon(Icons.fire_truck_rounded),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter Delivery charge";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              delivery_charge = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                color: highlight1 ? Colors.red : Colors.white,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: imageFileList.map((imageFile) {
                                      final index =
                                          imageFileList.indexOf(imageFile);
                                      return GestureDetector(
                                        onTap: () {
                                          removeImage(index);
                                          // Handle image tap or removal here
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Container(
                                            width:
                                                200, // Set the width as needed
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 253, 251, 251),
                                                  width: 1),
                                              color: Colors.white,
                                            ),
                                            margin: const EdgeInsets.all(3),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                height: 300,
                                                child: Image.file(
                                                  File(imageFile.path),
                                                  fit: BoxFit.cover,
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
                                    backgroundColor:
                                        Colors.black, // background color
                                    foregroundColor: Colors.white,
                                  ),
                                  icon: Icon(Icons.image),
                                  label: Text("Select Product Images"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))),
            if (isupload)
              const Padding(
                padding: const EdgeInsets.all(10),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            if (!isupload)
              ElevatedButton.icon(
                  onPressed: btnclick,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // background color
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(Icons.upload_rounded),
                  label: Text("Upload"))
          ],
        ),
      ),
    ));
  }
}
