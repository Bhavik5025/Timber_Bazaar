import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wood_stockpile/wood_seller_dashboard/homescreen.dart';

class product_view extends StatefulWidget {
  final String cId;
  final String pid;
  final String productName;
  final String category;
  final String price;
  final String productDescription;
  final String delivery_charge;
  final List<String> productImages;
  product_view({
    Key? key, // Use Key? instead of super.key
    required this.cId,
    required this.pid,
    required this.productName,
    required this.category,
    required this.price,
    required this.delivery_charge,
    required this.productDescription,
    required this.productImages,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _pview();
  }
}

class _pview extends State<product_view> {
  var isupload = false;
  final _formkey = GlobalKey<FormState>();
  var pname = "";
  var pdescription = "";
  var pprice;
  var pdelivery_charge;
  void updatebtn() {
    final isvalid = _formkey.currentState!.validate();
    if (!isvalid) {
      //show error message....

      return;
    } else {
      _formkey.currentState!.save();
      final CollectionReference products =
          FirebaseFirestore.instance.collection('products');
      products.doc(widget.pid).update({
        "product_name": pname,
        "price": pprice,
        "product_description": pdescription,
        "delivery_charge": pdelivery_charge,
      }).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product details update Successfully.')));
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
              child: Container(
                height: 300,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      for (String imageUrl in widget.productImages)
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
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: widget.productName,
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
                          pname = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: widget.productDescription,
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
                          pdelivery_charge = value!;
                        },
                      ),
                    ),
                    if (isupload)
                      const Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
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
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
