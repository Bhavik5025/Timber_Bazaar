import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wood_stockpile/models/product_model.dart';
import 'package:wood_stockpile/wood_seller_dashboard/product_view.dart';

class product_list extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _plist();
  }
}

class _plist extends State<product_list> {
  List<ProductModel> products = [];
  void fetchproducts() async {
    var data = await FirebaseFirestore.instance.collection("products").get();
    mapproducts(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchproducts();
  }

  mapproducts(QuerySnapshot<Map<String, dynamic>> document) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var w_list = document.docs
        .where((element) =>
            element["Company_email"] == prefs.getString('company_email'))
        .map((wlist) => ProductModel(
              companyEmail: wlist["Company_email"],
              cId: wlist["c_id"],
              pid:wlist["pid"],
              productName: wlist["product_name"],
              category: wlist["category"],
              price: wlist["price"],
              productDescription: wlist["product_description"],
              delivery_charge: wlist["delivery_charge"],
              productImages:
                  (wlist["product_images"] as List<dynamic>).cast<String>(),
            ))
        .toList();
    setState(() {
      products.addAll(w_list);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
        appBar: AppBar(
          title: Text("Wood StockPile"),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                  elevation: 4, // You can adjust the elevation for the cards
                  margin:
                      EdgeInsets.all(8), // You can adjust the margins as needed
                  child: ListTile(
                      title: Text(products[index].productName.toString()),
                      subtitle:
                          Text(products[index].productDescription.toString()),
                      // Add a subtitle if needed
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 2),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    animation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.elasticInOut);
                                    const begin = Offset(0.0, 1.0);
                                    const end = Offset.zero;
                                    final tween = Tween(begin: begin, end: end);
                                    final offsetAnimation =
                                        animation.drive(tween);
                                    return SlideTransition(
                                      child: child,
                                      position: offsetAnimation,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return product_view(
                                      pid:products[index].pid.toString(),
                                      productName: products[index]
                                          .productName
                                          .toString(),
                                      productDescription: products[index]
                                          .productDescription
                                          .toString(),
                                      productImages: products[index]
                                          .productImages
                                          .toList(),
                                      price: products[index].price.toString(),
                                      cId: products[index].cId.toString(),
                                      delivery_charge:products[index].delivery_charge.toString(),
                                      category:
                                          products[index].category.toString(),
                                    );
                                  }));
                        },
                        child: Text("View Product"),
                      )));
            })));
  }
}
