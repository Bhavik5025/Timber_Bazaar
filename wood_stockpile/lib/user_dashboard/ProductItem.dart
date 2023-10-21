import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wood_stockpile/user_dashboard/product_display.dart';
import 'package:wood_stockpile/wood_seller_dashboard/product_view.dart';

class ProductListItem extends StatefulWidget {
  final String productName;
  final String productDescription;
  final List<String> productImages;
  final String price;
  final String cId;
  final String pid;

  final String category;

  final String delivery_charge;

  ProductListItem(
      {required this.productName,
      required this.productDescription,
      required this.productImages,
      required this.cId,
      required this.pid,
      required this.category,
      required this.delivery_charge,
      required this.price});

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  double? mlet;
  double? mlong;
  String? cnumber;
  String? cemail;
  String? cname;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mlet = prefs.getDouble("let");
      mlong = prefs.getDouble("long");
      cnumber = prefs.getString("unumber");
      cemail = prefs.getString("uemail");
      cname = prefs.getString("uname");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Define the border color
            width: 0.5, // Define the border width
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the product image with a specific aspect ratio
            AspectRatio(
              aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
              child: Image.network(
                widget.productImages
                    .first, // Display the first image from the list
                fit: BoxFit.cover, // Adjust BoxFit as needed
              ),
            ),
            // Display product details below the image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Text(
                      'Product Name: ${widget.productName}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Row(
                      children: [
                        Text(
                          'Product Price: ${widget.price}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.currency_rupee_sharp),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            Duration(seconds: 2),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          animation = CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.elasticInOut);
                                          const begin = Offset(0.0, 1.0);
                                          const end = Offset.zero;
                                          final tween =
                                              Tween(begin: begin, end: end);
                                          final offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            child: child,
                                            position: offsetAnimation,
                                          );
                                        },
                                        pageBuilder: (context, animation,
                                            animationTime) {
                                          return product_display(
                                            pid: widget.pid,
                                            productName: widget.productName,
                                            productDescription:
                                                widget.productDescription,
                                            productImages: widget.productImages,
                                            price: widget.price,
                                            cId: widget.cId,
                                            delivery_charge:
                                                widget.delivery_charge,
                                            category: widget.category,
                                            let: mlet!,
                                            long: mlong!,
                                            cnumber: cnumber!,
                                            cname: cname!,
                                            cemail: cemail!,
                                          );
                                        }));
                              },
                              icon: Icon(Icons.view_carousel),
                              label: Text("View")),
                        )
                      ],
                    ),
                  ),
                  //

                  // Add more product details as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
