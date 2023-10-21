import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wood_stockpile/user_dashboard/ProductItem.dart';

import '../models/product_model.dart';

class products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _product();
  }
}

class _product extends State<products> {
  List<ProductModel> products = [];
  void fetchproducts() async {
    var data = await FirebaseFirestore.instance.collection("products").get();
    mapproducts(data);
  }

  @override
  void dispose() {
    // Cancel any ongoing asynchronous operations here.
    super.dispose();
  }

  mapproducts(QuerySnapshot<Map<String, dynamic>> document) async {
    var w_list = document.docs
        .map((wlist) => ProductModel(
              companyEmail: wlist["Company_email"],
              cId: wlist["c_id"],
              pid: wlist["pid"],
              productName: wlist["product_name"],
              category: wlist["category"],
              price: wlist["price"],
              productDescription: wlist["product_description"],
              delivery_charge: wlist["delivery_charge"],
              productImages:
                  (wlist["product_images"] as List<dynamic>).cast<String>(),
            ))
        .toList();
    if (mounted) {
      setState(() {
        products.addAll(w_list);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchproducts();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductListItem(
            productName: products[index].productName.toString(),
            productDescription: products[index].productDescription.toString(),
            price: products[index].price.toString(),
            productImages: products[index].productImages.toList(),
             pid: products[index].pid.toString(),
                                  
                                  cId: products[index].cId.toString(),
                                  delivery_charge: products[index]
                                      .delivery_charge
                                      .toString(),
                                  category: products[index].category.toString(),
          );
        
        }));
  }
}
