import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:wood_stockpile/wood_seller_dashboard/homescreen.dart';

class Wood_view extends StatefulWidget {
  final String cId;
  final String pid;
  final String width;
  final String thickness;
  final String height;
  final String wood_type;
  final String category;
  final String price;
  final String woodDescription;
  final String delivery_charge;
  final List<String> woodImages;
  Wood_view(
      {Key? key, // Use Key? instead of super.key
      required this.cId,
      required this.pid,
      required this.category,
      required this.wood_type,
      required this.price,
      required this.delivery_charge,
      required this.woodDescription,
      required this.woodImages,
      required this.height,
      required this.width,
      required this.thickness})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _wview();
  }
}

class _wview extends State<Wood_view> {
  var isupload = false;
  final _formkey = GlobalKey<FormState>();
  void updatebtn() {
    final isvalid = _formkey.currentState!.validate();
    if (!isvalid) {
      //show error message....

      return;
    } else {
      _formkey.currentState!.save();
      final CollectionReference products =
          FirebaseFirestore.instance.collection('woods');
      selectedWoodHeight ??= widget.height;
      selectedWoodThickness ??= widget.thickness;
      selectedWoodType ??= widget.wood_type;
      selectedWoodWidth ??= widget.width;

      products.doc(widget.pid).update({
        "wood_width": selectedWoodWidth,
        "wood_height": selectedWoodHeight,
        "wood_type": selectedWoodType,
        "wood_thickness": selectedWoodThickness,
        "price": pprice,
        "wood_description": pdescription,
        "delivery_charge": pdelivery_charge,
      }).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('wood details update Successfully.')));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => homescreen()),
          );
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'update failed.')));
      });
    }
  }

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
  var pdescription = "";
  var pprice;
  var pdelivery_charge;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
        appBar: AppBar(
          title: Text("Wood StockPile"),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (String imageUrl in widget.woodImages)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black, // Define the border color
                  width: 0.5, // Define the border width
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Wood Type",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, top: 8, bottom: 8),
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
                                widget.wood_type,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black, // Define the border color
                  width: 0.5, // Define the border width
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Wood Height",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 47, top: 8, bottom: 8),
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
                                widget.height,
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black, // Define the border color
                  width: 0.5, // Define the border width
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Wood Width",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55, top: 8, bottom: 8),
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
                                widget.width,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black, // Define the border color
                  width: 0.5, // Define the border width
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Wood Thickness",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, top: 8, bottom: 8),
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
                                widget.thickness,
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
            ),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: widget.woodDescription,
                    decoration: const InputDecoration(
                      labelText: "Wood Description",
                      prefixIcon: Icon(Icons.description),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
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
                      pdescription = value!;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: widget.price,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Wood Price",
                      prefixIcon: Icon(Icons.currency_rupee_sharp),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
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
                      pprice = value!;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: widget.delivery_charge,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Delivery charge per Kilometer",
                      prefixIcon: Icon(Icons.fire_truck_rounded),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
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
                      pdelivery_charge = value!;
                    },
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
                onPressed: updatebtn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background color
                  foregroundColor: Colors.white,
                ),
                icon: Icon(Icons.save_as_outlined),
                label: Text("Save Changes"))
        ]))));
  }
}
