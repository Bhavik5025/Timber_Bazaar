// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// import '../models/product_wood_model.dart';
// import '../models/wood_seller.dart';

// class order_view extends StatefulWidget {
//   String companyId;
//   String customerId;
//   String orderid;
//   String paymentId;
//   String productname;
//   String productid;
//   String type;
//   String totalPrice;
//   String deliveryCharge;
//   order_view({
//     required this.companyId,
//     required this.customerId,
//     required this.orderid,
//     required this.paymentId,
//     required this.productid,
//     required this.productname,
//     required this.type,
//     required this.totalPrice,
//     required this.deliveryCharge,
//   });
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _orderview();
//   }
// }

// class _orderview extends State<order_view> {
//   double? mlet;
//   double? price;
//   double? mlong;
//   String orderId = Uuid().v4();
//   List<ProductWoodModel> woods = [];
//   WoodSeller? woodsellers;

//   List<String> productImages = [];
//   @override
//   void initState() {
//     super.initState();

//     // Initialize Razorpay with your options

//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final prefs = await SharedPreferences.getInstance();
//     mlet = prefs.getDouble("let");
//     mlong = prefs.getDouble("long");

//     if (mlet != null && mlong != null) {
//       //   someMethod();
//     }
//     fetchproduct();
//   }

//   void fetchproduct() async {
//     if (widget.type == "wood") {
//       var data = await FirebaseFirestore.instance.collection("woods").get();
//       mapwoods(data);
//     }
//   }

//   mapwoods(QuerySnapshot<Map<String, dynamic>> document) async {
//     var w_list = document.docs.map((wlist) {
//       return (ProductWoodModel(
//         companyEmail: wlist["Company_email"],
//         cId: wlist["c_id"],
//         pid: wlist["pid"],
//         width: wlist["wood_width"],
//         height: wlist["wood_height"],
//         thickness: wlist["wood_thickness"],
//         woodType: wlist["wood_type"],
//         category: wlist["category"],
//         price: wlist["price"],
//         woodDescription: wlist["wood_description"],
//         delivery_charge: wlist["delivery_charge"],
//         woodImages: (wlist["wood_images"] as List<dynamic>).cast<String>(),
//       ));
//     }).toList();
//     setState(() {
//       woods.addAll(w_list);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Order Details"),
//         backgroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   height: 300,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: <Widget>[
//                         for (ProductWoodModel product in woods)
//                           Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 CachedNetworkImage(
//                                   imageUrl: product.woodImages[
//                                       0], // Assuming you want to display the first image
//                                   fit: BoxFit.fitWidth,
//                                   placeholder: (context, url) =>
//                                       CircularProgressIndicator(), // Display a loading indicator
//                                   errorWidget: (context, url, error) => Icon(Icons
//                                       .error), // Display an error icon if the image fails to load
//                                 ),
//                                 Text(product.woodType),
//                                 Text("Price: \$${product.price}"),
//                                 Text("Description: ${product.woodDescription}"),
//                                 // Add more details as needed
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../models/product_model.dart';
import '../models/product_wood_model.dart';
import '../models/wood_seller.dart';

class company_order_view extends StatefulWidget {
  // ... Your existing code ...
  String companyId;
  String customerId;
  String orderid;
  String paymentId;
  String productname;
  String productid;
  String customername;
  String type;
  String companyname;
  String companylet;
  String companylong;
  String customerlet;
  String customerlong;
  String companyaddress;
  String companynumber;
  String customernumber;
  String totalPrice;
  String deliveryCharge;
  company_order_view({
    required this.companyId,
    required this.customerId,
    required this.orderid,
    required this.companylet,
    required this.companylong,
    required this.customerlet,
    required this.customerlong,
    required this.paymentId,
    required this.productid,
    required this.productname,
    required this.companyname,
    required this.customernumber,
    required this.companyaddress,
    required this.companynumber,
    required this.customername,
    required this.type,
    required this.totalPrice,
    required this.deliveryCharge,
  });

  @override
  State<StatefulWidget> createState() {
    return _orderview();
  }
}

class _orderview extends State<company_order_view> {
  // ... Your existing code ...
  double? mlet;
  double? price;
  double? mlong;
  List<ProductWoodModel> woods = [];
  List<ProductModel> products = [];
  WoodSeller? woodsellers;
  GoogleMapController? _controller;
  List<String> productImages = [];
  @override
  void initState() {
    super.initState();
    if (widget.type == "wood") {
      fetchData();
    }
    if (widget.type == "furniture") {
      fetchfurnituredata();
    }
  }

  Future<void> fetchfurnituredata() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("products")
          .where("pid", isEqualTo: widget.productid)
          .get();

      if (data.docs.isNotEmpty) {
        mapfurnitures(data);
      } else {
        print("No wood products found.");
      }
    } catch (e) {
      print("Error fetching wood products: $e");
    }
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("woods")
          .where("pid", isEqualTo: widget.productid)
          .get();

      if (data.docs.isNotEmpty) {
        mapWoods(data);
      } else {
        print("No wood products found.");
      }
    } catch (e) {
      print("Error fetching wood products: $e");
    }
  }

  void mapfurnitures(QuerySnapshot<Map<String, dynamic>> document) async {
    var w_list = document.docs.map((wlist) {
      return ProductModel(
        companyEmail: wlist["Company_email"],
        cId: wlist["c_id"],
        pid: wlist["pid"],
        category: wlist["category"],
        price: wlist["price"],
        productName: wlist["product_name"],
        productDescription: wlist["product_description"],
        delivery_charge: wlist["delivery_charge"],
        productImages:
            (wlist["product_images"] as List<dynamic>).cast<String>(),
      );
    }).toList();
    setState(() {
      products.addAll(w_list);
    });
  }
  // ... Your existing code ...

  void mapWoods(QuerySnapshot<Map<String, dynamic>> document) async {
    var w_list = document.docs.map((wlist) {
      return ProductWoodModel(
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
        woodImages: (wlist["wood_images"] as List<dynamic>).cast<String>(),
      );
    }).toList();
    setState(() {
      woods.addAll(w_list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.type == "wood")
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          for (ProductWoodModel product in woods)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 300,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        for (ProductWoodModel product in woods)
                                          for (String imageurl
                                              in product.woodImages)
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Image.network(
                                                imageurl,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (widget.type == "furniture")
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          for (ProductModel product in products)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 300,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        for (ProductModel product in products)
                                          for (String imageurl
                                              in product.productImages)
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Image.network(
                                                imageurl,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: widget.productname,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  prefixIcon: Icon(Icons.description),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue:
                    (double.parse(widget.totalPrice) / 100).toString(),
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Product price",
                  prefixIcon: Icon(Icons.currency_rupee_sharp),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: widget.paymentId,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Payment Id",
                  prefixIcon: Icon(Icons.payment),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: widget.orderid,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Order Id",
                  prefixIcon: Icon(Icons.document_scanner),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: widget.customername,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Customer Name",
                  prefixIcon: Icon(Icons.description),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 200,
                child: GoogleMap(
                  key: const Key('AIzaSyAr1dn7Gm4qQzKjgqocTqTCya1g8CKp7ZY'),
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(widget.customerlet),
                        double.parse(widget.customerlong)),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('Source'),
                      position: LatLng(double.parse(widget.companylet),
                          double.parse(widget.companylong)),
                      infoWindow: InfoWindow(title: 'Source'),
                    ),
                    Marker(
                      markerId: MarkerId('Destination'),
                      position: LatLng(double.parse(widget.customerlet),
                          double.parse(widget.customerlong)),
                      infoWindow: InfoWindow(title: 'Destination'),
                    ),
                  },
                  polylines: {
                    Polyline(
                      polylineId: PolylineId('Route'),
                      points: [
                        LatLng(double.parse(widget.companylet),
                            double.parse(widget.companylong)),
                        LatLng(double.parse(widget.customerlet),
                            double.parse(widget.customerlong))
                      ],
                      color: Colors.blue,
                      width: 5,
                    ),
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                onTap: () {
                  UrlLauncher.launch('tel:+91${widget.customernumber}');
                },
                initialValue: widget.companynumber,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Customer Mobile",
                  prefixIcon: Icon(Icons.description),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
