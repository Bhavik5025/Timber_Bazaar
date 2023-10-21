import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wood_stockpile/models/order_model.dart';
import 'package:wood_stockpile/user_dashboard/company_order_view.dart';
import 'package:wood_stockpile/user_dashboard/order_view.dart';

class my_orders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _order();
  }
}

class _order extends State<my_orders> {
  List<OrderModel> products = [];
  var productprice = 0.0;
  void fetchproducts() async {
    var data = await FirebaseFirestore.instance.collection("orders").get();
    mapproducts(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchproducts();
  }

  @override
  void dispose() {
    // Cancel any ongoing asynchronous operations here.
    super.dispose();
  }

  mapproducts(QuerySnapshot<Map<String, dynamic>> document) async {
    var w_list = document.docs
        .where((element) =>
            element["Company_id"] == FirebaseAuth.instance.currentUser!.uid)
        .map((wlist) {
      return OrderModel(
        companyId: wlist["Company_id"],
        customerId: wlist["Customer_id"],
        orderid: wlist["orderid"],
        paymentId: wlist["paymentId"],
        productid: wlist["productid"],
        productname: wlist["product_name"],
        company_name: wlist["company_name"],
        customername: wlist["customername"],
        companylet: wlist["companylet"].toString(),
        companylong: wlist["companylong"].toString(),
        customerlet: wlist["customerlet"].toString(),
        customerlong: wlist["customerlong"].toString(),
        customernumber: wlist["customer_number"].toString(),
        company_address: wlist["company_address"],
        company_number: wlist["company_number"],
        type: wlist["type"],
        totalPrice: wlist["total_price"],
        deliveryCharge: wlist["delivery_charge"],
      );
    }).toList();
    if (mounted) {
      setState(() {
        products.addAll(w_list);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 4, // You can adjust the elevation for the cards
              margin: EdgeInsets.all(8), // You can adjust the margins as needed
              child: ListTile(
                  title: Text(products[index].productname.toString()),
                  subtitle: Row(
                    children: <Widget>[
                      Text("Total price: " +
                          (double.parse(products[index].totalPrice) / 100)
                              .toString()),
                      Icon(Icons
                          .currency_rupee_sharp), // Replace 'your_icon' with the desired icon
                    ],
                  ),
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
                                final offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  child: child,
                                  position: offsetAnimation,
                                );
                              },
                              pageBuilder: (context, animation, animationTime) {
                                return company_order_view(
                                  companylet:
                                      products[index].companylet.toString(),
                                  companylong:
                                      products[index].companylong.toString(),
                                  customerlet:
                                      products[index].customerlet.toString(),
                                  customerlong:
                                      products[index].customerlong.toString(),
                                  customername:
                                      products[index].customername.toString(),
                                  companyId:
                                      products[index].companyId.toString(),
                                  customerId:
                                      products[index].customerId.toString(),
                                  customernumber:
                                      products[index].customernumber.toString(),
                                  companyname:
                                      products[index].company_name.toString(),
                                  companyaddress: products[index]
                                      .company_address
                                      .toString(),
                                  companynumber:
                                      products[index].company_number.toString(),
                                  orderid: products[index].orderid.toString(),
                                  paymentId:
                                      products[index].paymentId.toString(),
                                  productid:
                                      products[index].productid.toString(),
                                  productname:
                                      products[index].productname.toString(),
                                  type: products[index].type.toString(),
                                  totalPrice:
                                      products[index].totalPrice.toString(),
                                  deliveryCharge:
                                      products[index].deliveryCharge.toString(),
                                );
                              }));
                    },
                    child: Text("View Order"),
                  )));
        }));
  }
}
