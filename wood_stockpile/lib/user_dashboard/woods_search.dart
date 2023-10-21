import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:wood_stockpile/user_dashboard/wood_items.dart';

import '../models/product_wood_model.dart';

class woodsearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _woodsearch();
  }
}

class _woodsearch extends State<woodsearch> {
  final _formkey = GlobalKey<FormState>();
  List<ProductWoodModel> products = [];
  var productStatus = "abc";
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

  void btnclick(BuildContext context) async {
    final isvalid = _formkey.currentState!.validate();
    if (selectedWoodType == null) {
      Fluttertoast.showToast(
        msg: 'Please Select Wood Type',
        backgroundColor: Colors.red,
        gravity: ToastGravity.TOP, // Adjust toast position
        toastLength: Toast.LENGTH_LONG, // Adjust toast duration
      );
    } else if (selectedWoodWidth == null) {
      Fluttertoast.showToast(
        msg: 'Please Select Wood Width',
        backgroundColor: Colors.red,
        gravity: ToastGravity.TOP, // Adjust toast position
        toastLength: Toast.LENGTH_LONG, // Adjust toast duration
      );
    } else if (selectedWoodHeight == null) {
      Fluttertoast.showToast(
        msg: 'Please Select Wood Height',
        backgroundColor: Colors.red,
        gravity: ToastGravity.TOP, // Adjust toast position
        toastLength: Toast.LENGTH_LONG, // Adjust toast duration
      );
    } else if (selectedWoodThickness == null) {
      Fluttertoast.showToast(
        msg: 'Please Select Wood Thickness',
        backgroundColor: Colors.red,
        gravity: ToastGravity.TOP, // Adjust toast position
        toastLength: Toast.LENGTH_LONG, // Adjust toast duration
      );
    } else {
      if (!isvalid) {
        //show error message....

        return;
      } else {
        var data = await FirebaseFirestore.instance.collection("woods").get();
        mapproducts(data);
      }
    }
  }

  mapproducts(QuerySnapshot<Map<String, dynamic>> document) async {
    var w_list = document.docs
        .where((element) =>
            element["wood_type"] == selectedWoodType &&
            element["wood_width"] == selectedWoodWidth &&
            element["wood_height"] == selectedWoodHeight &&
            element["wood_thickness"] == selectedWoodThickness)
        .map((wlist) => ProductWoodModel(
              companyEmail: wlist["Company_email"],
              cId: wlist["c_id"],
              pid: wlist["pid"],
              width: wlist["wood_width"],
              height: wlist["wood_height"],
              thickness: wlist["wood_thickness"],
              woodType: wlist["wood_type"],
              category: wlist["category"],
              price: wlist["price"],
              woodDescription: wlist["wood_description"],
              delivery_charge: wlist["delivery_charge"],
              woodImages:
                  (wlist["wood_images"] as List<dynamic>).cast<String>(),
            ))
        .toList();
    setState(() {
      products.addAll(w_list);
    });
    if (products.isEmpty) {
      setState(() {
        productStatus = "true";
      });
    } else {
      setState(() {
        productStatus = "false";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 8, bottom: 8, right: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
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
                              "Select height",
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
                      value: selectedWoodHeight,
                      onChanged: (String? value) {
                        setState(() {
                          selectedWoodHeight = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
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
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
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
                              "Select Width",
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
                      value: selectedWoodWidth,
                      onChanged: (String? value) {
                        setState(() {
                          selectedWoodWidth = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
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
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
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
                              "Select Wood Thickness",
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
                        width: 220,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50, // Set the height of the button here
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => btnclick(context),
                      icon: Icon(Icons.search),
                      label: Text("Search"),
                    ),
                  ),
                )
              ],
            ),
            if (productStatus == "true")
              SizedBox(
                  height: 300, // Adjust the height as needed
                  child: Lottie.asset("assets/lottie/Not_Found.json")),
            if (productStatus == "true")
              Text(
                "Product Not Found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            if (productStatus == "false")
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return woodListItem(
                    producttype: products[index].woodType.toString(),
                    productDescription:
                        products[index].woodDescription.toString(),
                    width: products[index].width.toString(),
                    height: products[index].height.toString(),
                    thickness: products[index].thickness.toString(),
                    price: products[index].price.toString(),
                    productImages: products[index].woodImages.toList(),
                    pid: products[index].pid.toString(),
                    cId: products[index].cId.toString(),
                    delivery_charge: products[index].delivery_charge.toString(),
                    category: products[index].category.toString(),
                  );
                },
              ),
          ],
        ),
      ),
    ));
  }
}
