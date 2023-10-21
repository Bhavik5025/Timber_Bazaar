// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// class WoodDetails extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _woodDetails();
//   }
// }

// class _woodDetails extends State<WoodDetails> {
//   final List<String> items = [
//     'Sag Wood',
//     'Salwood',
//     'Teak Wood',
//     'Deodar Wood',
//     'Marandi Wood',
//     'Walnut Wood',
//     'Rosewood'
//   ];
//   final List<String> items1 = [
//     'Select Wood Width',
//     '0.5 inch',
//     '1 inch',
//     '1.5 inch',
//     '2 inch',
//     '2.5 inch',
//     '3 inch'
//   ];
//   bool isDropdownOpened = false;
//   String? selectedValue;
//   String? selectedWidth; // Initial value

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return (Scaffold(
//       appBar: AppBar(
//         title: Text("Wood StockPile"),
//         backgroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Center(
//                 child: Text(
//                   "Add Wood Details",
//                   style: TextStyle(fontSize: 24),
//                 ),
//               ),
//             ),
//             Form(
//                 child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border:
//                             Border.all(color: Colors.black.withOpacity(0.2))),
//                     child: Stack(
//                       children: [
//                         Column(
//                           children: [
//                             DropdownButtonHideUnderline(
//                               child: DropdownButton2<String>(
//                                 isExpanded: true,
//                                 hint: const Row(
//                                   children: [
//                                     Icon(
//                                       Icons.list,
//                                       size: 16,
//                                       color: Color.fromARGB(255, 16, 16, 16),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Select Wood Type',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color.fromARGB(255, 0, 0, 0),
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 items: items
//                                     .map((String item) =>
//                                         DropdownMenuItem<String>(
//                                           value: item,
//                                           child: Text(
//                                             item,
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Color.fromARGB(255, 0, 0, 0),
//                                             ),
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ))
//                                     .toList(),
//                                 value: selectedValue,
//                                 onChanged: (String? value) {
//                                   setState(() {
//                                     selectedValue = value;
//                                   });
//                                 },
//                                 // Your existing buttonStyleData, iconStyleData, and dropdownStyleData
//                               ),
//                             ),
//                           ],
//                         ),
//                         if (isDropdownOpened)
//                           Positioned(
//                             top: 100, // Adjust the top position as needed
//                             left: 0,
//                             right: 0,
//                             child: Card(
//                               elevation: 2,
//                               child: ListView(
//                                 shrinkWrap: true,
//                                 children: items
//                                     .map((item) => ListTile(
//                                           title: Row(
//                                             children: [
//                                               Icon(Icons.abc),
//                                               Text(item),
//                                             ],
//                                           ),
//                                           onTap: () {
//                                             setState(() {
//                                               selectedValue = item;
//                                               isDropdownOpened = false;
//                                             });
//                                           },
//                                         ))
//                                     .toList(),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     children: [
//                       DropdownButtonHideUnderline(
//                         child: DropdownButton2<String>(
//                           isExpanded: true,
//                           hint: const Row(
//                             children: [
//                               Icon(
//                                 Icons.list,
//                                 size: 16,
//                                 color: Color.fromARGB(255, 0, 0, 0),
//                               ),
//                               SizedBox(
//                                 width: 4,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Select Wood Width',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color.fromARGB(255, 0, 0, 0),
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           items: items1
//                               .map((String item) => DropdownMenuItem<String>(
//                                     value: item,
//                                     child: Text(
//                                       item,
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ))
//                               .toList(),
//                           value: selectedValue,
//                           onChanged: (String? value) {
//                             setState(() {
//                               selectedValue = value;
//                             });
//                           },
//                           buttonStyleData: ButtonStyleData(
//                             height: 50,
//                             width: 200,
//                             padding: const EdgeInsets.only(left: 14, right: 14),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               border: Border.all(
//                                 color: Colors.black26,
//                               ),
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                             ),
//                             elevation: 2,
//                           ),
//                           iconStyleData: const IconStyleData(
//                             icon: Icon(
//                               Icons.arrow_forward_ios_outlined,
//                             ),
//                             iconSize: 14,
//                             iconEnabledColor: Color.fromARGB(255, 0, 0, 0),
//                             iconDisabledColor: Colors.grey,
//                           ),
//                           dropdownStyleData: DropdownStyleData(
//                             maxHeight: 200,
//                             width: 200,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               color: Color.fromARGB(255, 0, 0, 0),
//                             ),
//                             offset: const Offset(-20, 0),
//                             scrollbarTheme: ScrollbarThemeData(
//                               radius: const Radius.circular(40),
//                               thickness: MaterialStateProperty.all<double>(6),
//                               thumbVisibility:
//                                   MaterialStateProperty.all<bool>(true),
//                             ),
//                           ),
//                           menuItemStyleData: const MenuItemStyleData(
//                             height: 40,
//                             padding: EdgeInsets.only(left: 14, right: 14),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ))
//           ],
//         ),
//       ),
//     ));
//   }
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:wood_stockpile/wood_seller_dashboard/homescreen.dart';

class WoodDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WoodDetailsState();
  }
}

class _WoodDetailsState extends State<WoodDetails> {
  final List<String> woodTypes = [
    'Sag Wood',
    'Salwood',
    'Teak Wood',
    'Deodar Wood',
    'Marandi Wood',
    'Walnut Wood',
    'Rosewood'
  ];
  final List<String> woodWidths = [
    '0.5 inch',
    '1 inch',
    '1.5 inch',
    '2 inch',
    '2.5 inch',
    '3 inch'
  ];
  final List<String> woodHeights = [
    '1 feet',
    '1.25 feet',
    '1.5 feet',
    '1.75 feet',
    '2  feet',
    '2.25 feet',
    '2.5 feet',
    '2.75 feet',
    '3 feet',
    '3.25 feet',
    '3.5 feet',
    '3.75 feet',
    '4 feet',
    '4.25 feet',
    '4.5 feet',
    '4.75 feet',
    '5 feet',
    '5.25 feet',
    '5.50 feet',
    '5.75 feet',
    '6 feet',
    '6.25 feet',
    '6.50 feet',
    '6.75 feet',
    '7 feet',
    '7.25 feet',
    '7.5 feet',
    '7.75 feet',
    '8 feet',
    '8.25 feet',
    '8.5 feet',
    '8.75 feet',
    '9 feet',
    '9.25 feet',
    '9.50 feet',
    '9.75 feet',
    '10 feet',
    '10.25 feet',
    '10.50 feet',
    '10.75 feet',
    '11 feet',
    '11.25 feet',
    '11.50 feet',
    '11.75 feet',
    '12 feet'
  ];
  final List<String> woodthickness = [
    '1 Inch',
    '1.25 Inch',
    '1.5 Inch',
    '1.75 Inch',
    '2  Inch',
    '2.25 Inch',
    '2.5 Inch',
    '2.75 Inch',
    '3 Inch',
    '3.25 Inch',
    '3.5 Inch',
    '3.75 Inch',
    '4 Inch',
    '4.25 Inch',
    '4.5 Inch',
    '4.75 Inch',
    '5 Inch',
    '5.25 Inch',
    '5.50 Inch',
    '5.75 Inch',
    '6 Inch',
    '6.25 Inch',
    '6.50 Inch',
    '6.75 Inch',
    '7 Inch',
    '7.25 Inch',
    '7.5 Inch',
    '7.75 Inch',
    '8 Inch',
    '8.25 Inch',
    '8.5 Inch',
    '8.75 Inch',
    '9 Inch',
    '9.25 Inch',
    '9.50 Inch',
    '9.75 Inch',
    '10 Inch',
    '10.25 Inch',
    '10.50 Inch',
    '10.75 Inch',
    '11 Inch',
  ];
  String? selectedWoodHeight;
  String? selectedWoodType;
  String? selectedWoodWidth;
  String? selectedWoodThickness;
  dynamic wood_price;
  var wood_description = "";
  String productId = Uuid().v4();
  String imagesId = Uuid().v4();
  var highlight1 = false;
  dynamic delivery_charge;
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('company_email'));
    final isvalid = _formkey.currentState!.validate();
    if (selectedWoodType == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select Wood Type')));
    } else if (selectedWoodWidth == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select Wood Width')));
    } else if (selectedWoodHeight == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select Wood Height')));
    } else if (selectedWoodThickness == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please Select Wood Thickness')));
    } else {
      if (!isvalid) {
        //show error message....

        return;
      }
      if (imageFileList.isEmpty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Please add Wood Images.')));
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
          final Reference storageRef =
              storage.ref().child('wood_Images').child(productId);
          for (int i = 0; i < imageFileList.length; i++) {
            final XFile imageFile = imageFileList[i];
            final String fileName =
                'image_$i.jpg'; // Unique name for each image
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
              .collection('woods')
              .doc(imagesId)
              .set({
            "Company_email": prefs.getString('company_email'),
            "c_id": FirebaseAuth.instance.currentUser!.uid,
            "pid": productId,
            "wood_type": selectedWoodType,
            "wood_width": selectedWoodWidth,
            "wood_height": selectedWoodHeight,
            "wood_thickness": selectedWoodThickness,
            "category": "wood",
            "price": wood_price,
            "wood_description": wood_description,
            "wood_images": downloadurl,
            "delivery_charge": delivery_charge,
          });
          setState(() {
            isupload = false;
          });
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Wood Details Upload Successfully')));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wood StockPile"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Add Wood Details",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: const Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    size: 16,
                                    color: Color.fromARGB(255, 16, 16, 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Select Wood Type',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: woodTypes
                                  .map((String item) =>
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedWoodType,

                              onChanged: (String? value) {
                                setState(() {
                                  selectedWoodType = value;
                                });
                              },
                              // Your existing buttonStyleData, iconStyleData, and dropdownStyleData
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: const Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    size: 16,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Wood Width',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: woodWidths
                                  .map((String item) =>
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedWoodWidth,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedWoodWidth = value;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: 160,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(66, 255, 255, 255),
                                  ),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                                elevation: 2,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor: Color.fromARGB(255, 0, 0, 0),
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                offset: const Offset(-20, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness:
                                      MaterialStateProperty.all<double>(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 30, right: 14),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: const Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    size: 16,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Wood Height',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: woodHeights
                                  .map((String item) =>
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedWoodHeight,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedWoodHeight = value;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: 160,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(66, 255, 255, 255),
                                  ),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                                elevation: 2,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor: Color.fromARGB(255, 0, 0, 0),
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                offset: const Offset(-20, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness:
                                      MaterialStateProperty.all<double>(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 30, right: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Wood Thickness',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: woodthickness
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedWoodThickness,
                        onChanged: (String? value) {
                          setState(() {
                            selectedWoodThickness = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 190,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color.fromARGB(66, 255, 255, 255),
                            ),
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Color.fromARGB(255, 0, 0, 0),
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 30, right: 14),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Wood Description",
                        prefixIcon: Icon(Icons.description),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "please enter Wood Description";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        wood_description = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Wood Price",
                        prefixIcon: Icon(Icons.currency_rupee_sharp),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter Wood Price";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        wood_price = value!;
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
                                final index = imageFileList.indexOf(imageFile);
                                return GestureDetector(
                                  onTap: () {
                                    removeImage(index);
                                    // Handle image tap or removal here
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      width: 200, // Set the width as needed
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 253, 251, 251),
                                            width: 1),
                                        color: Colors.white,
                                      ),
                                      margin: const EdgeInsets.all(3),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
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
                              backgroundColor: Colors.black, // background color
                              foregroundColor: Colors.white,
                            ),
                            icon: Icon(Icons.image),
                            label: Text("Select Wood Images"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
    );
  }
}
