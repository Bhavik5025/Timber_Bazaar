import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:wood_stockpile/user_dashboard/ProductItem.dart';
import 'package:wood_stockpile/user_dashboard/Screen_1.dart';
import 'package:wood_stockpile/user_dashboard/home_screen.dart';
import 'package:wood_stockpile/wood_seller_dashboard/homescreen.dart';

import '../models/wood_seller.dart';
import "dart:math";

class searched_wood_display extends StatefulWidget {
  final String cId;
  final String pid;
  final String productName;
  final String category;
  final String price;
  final double let;
  final double long;
  final String width;
  final String height;
  final String thickness;
  final String cnumber;
  final String cname;
  final String cemail;
  final String productDescription;
  final String delivery_charge;
  final List<String> productImages;
  searched_wood_display({
    Key? key, // Use Key? instead of super.key
    required this.cId,
    required this.pid,
    required this.productName,
    required this.category,
    required this.width,
    required this.cname,
    required this.height,
    required this.thickness,
    required this.let,
    required this.cnumber,
    required this.cemail,
    required this.long,
    required this.price,
    required this.delivery_charge,
    required this.productDescription,
    required this.productImages,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _pdisplay();
  }
}

class _pdisplay extends State<searched_wood_display> {
  //Razorpay configuration

  double clet = 0.0;
  double clong = 0.0;
  double? mlet;
  double? price;
  double? mlong;
  String orderId = Uuid().v4();
  GoogleMapController? _controller;

  WoodSeller? woodsellers;

  bool isMapReady = false;
  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

    // Initialize Razorpay with your options

    fetchData();
  }

  Map<String, dynamic> getPaymentOptions() {
    // Replace with your payment details
    return {
      'key': 'rzp_test_ULKXFl3prtGM7z',
      'amount': ((double.parse(widget.price) +
                  (double.parse(widget.delivery_charge) *
                      double.parse(
                          distance(widget.let, widget.long, clet, clong)))) *
              100)
          .toInt(), // Amount in the smallest currency unit (e.g., paise).
      'name': 'Wood StockPile',
      'description': 'Furniture Purchase',
      'prefill': {
        'email': widget.cemail,
        'contact': widget.cnumber,
      },
      'external': {
        'wallets': ['paytm'],
      },
    };
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear the Razorpay instance when done
    super.dispose();
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
      "orderid": orderId,
      "paymentId": response.paymentId,
      "productid": widget.pid,
      "Company_id": widget.cId,
      "product_name": widget.productName,
      "company_name": woodsellers!.companyName,
      "company_address": woodsellers!.address,
      "company_number": woodsellers!.mobileNo,
      "customername": widget.cname,
      "customer_number": widget.cnumber,
      "companylet": clet,
      "companylong": clong,
      "customerlet": mlet,
      "customerlong": mlong,
      "type": "wood",
      "Customer_id": FirebaseAuth.instance.currentUser!.uid,
      "total_price": ((double.parse(widget.price) +
                  (double.parse(widget.delivery_charge) *
                      double.parse(
                          distance(widget.let, widget.long, clet, clong)))) *
              100)
          .toString(),
      "delivery_charge": (double.parse(widget.delivery_charge) *
              double.parse(distance(widget.let, widget.long, clet, clong)))
          .toString(),
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Order Successfully')));
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    });
    print("Payment successful: ${response.paymentId}");
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print("Payment failed: ${response.code}, ${response.message}");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    print("External wallet selected: ${response.walletName}");
  }

  void openRazorpay() {
    try {
      _razorpay.open(getPaymentOptions());
    } catch (e) {
      print("Error opening Razorpay: $e");
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
    isMapReady = true;
    someMethod();
  }

  void someMethod() {
    if (isMapReady && _controller != null && mlet != null && mlong != null) {
      _controller!.animateCamera(CameraUpdate.newLatLng(LatLng(mlet!, mlong!)));
    }
  }

  String distance(double lat1, double lon1, double lat2, double lon2) {
    const r = 6372.8; // Earth radius in kilometers

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final lat1Radians = _toRadians(lat1);
    final lat2Radians = _toRadians(lat2);

    final a =
        _haversin(dLat) + cos(lat1Radians) * cos(lat2Radians) * _haversin(dLon);
    final c = 2 * asin(sqrt(a));
    print("DIS ${r * c}");
    return (r * c).toString().substring(0, 5);
  }

  double _toRadians(double degrees) => degrees * pi / 180;

  double _haversin(double radians) => pow(sin(radians / 2), 2) as double;
  void fetchcompany() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("wood_seller")
          .where("uid", isEqualTo: widget.cId)
          .limit(1)
          .get();

      if (data.docs.isNotEmpty) {
        var doc = data.docs[0];
        var wlist = WoodSeller(
          uid: doc['uid'],
          companyName: doc['Company_name'],
          email: doc['email'],
          mobileNo: doc['Mobile_no'],
          certificate: doc['certificate'],
          type: doc['type'],
          images: (doc['images'] as List<dynamic>).cast<String>(),
          verified: doc['verified'],
          address: doc['Address'],
          latitude: doc['latitude'],
          longitude: doc['longitude'],
        );
        setState(() {
          woodsellers = wlist;
          clet = wlist.latitude;
          clong = wlist.longitude;
          someMethod();
        });
      }
    } catch (e) {
      print("Error fetching wood seller: $e");
    }
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    mlet = prefs.getDouble("let");
    mlong = prefs.getDouble("long");
    if (woodsellers != null) {
      price = (double.parse(widget.price) +
          (double.parse(widget.delivery_charge) *
              double.parse(distance(widget.let, widget.long, clet, clong))));
    }
    if (mlet != null && mlong != null) {
      someMethod();
    }
    fetchcompany();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController(
      text: widget.productName,
    );
    // TODO: implement build
    return (Scaffold(
      appBar: AppBar(
        title: Text("Wood StockPile"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
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
                              fit: BoxFit.fitWidth,
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
                initialValue: widget.productName,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  prefixIcon: Icon(Icons.table_bar),
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
                initialValue: widget.productDescription,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Product Description",
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
                initialValue: widget.width,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Wood Width",
                  prefixIcon: Icon(Icons.width_full),
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
                initialValue: widget.height,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Wood Height",
                  prefixIcon: Icon(Icons.height),
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
                initialValue: widget.thickness,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Wood Thickness",
                  prefixIcon: Icon(Icons.width_normal),
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
                      someMethod();
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.let, widget.long),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('Source'),
                      position: LatLng(mlet ?? 0, mlong ?? 0),
                      infoWindow: InfoWindow(title: 'Source'),
                    ),
                    if (woodsellers != null)
                      Marker(
                        markerId: MarkerId('Destination'),
                        position: LatLng(clet, clong),
                        infoWindow: InfoWindow(title: 'Destination'),
                      ),
                  },
                  polylines: {
                    if (woodsellers != null)
                      Polyline(
                        polylineId: PolylineId('Route'),
                        points: [
                          LatLng(mlet ?? 0, mlong ?? 0),
                          LatLng(clet, clong),
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
                initialValue: widget.price,
                readOnly: true, // Set readOnly to true to make it readonly
                decoration: const InputDecoration(
                  labelText: "Product Price",
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
            if (woodsellers != null)
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: (double.parse(widget.delivery_charge) *
                              double.parse(distance(
                                  widget.let, widget.long, clet, clong)))
                          .toString() +
                      '               Total Kms: ' +
                      distance(widget.let, widget.long, clet, clong) +
                      ' kms',

                  readOnly: true, // Set readOnly to true to make it readonly
                  decoration: const InputDecoration(
                    labelText: "Delivery Charge",
                    prefixIcon: Icon(Icons.fire_truck),
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
            if (woodsellers != null)
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: (double.parse(widget.price) +
                          (double.parse(widget.delivery_charge) *
                              double.parse(distance(
                                  widget.let, widget.long, clet, clong))))
                      .toString(),
                  readOnly: true, // Set readOnly to true to make it readonly
                  decoration: const InputDecoration(
                    labelText: "Total Price",
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
            if (woodsellers != null)
              ElevatedButton.icon(
                icon: Icon(Icons.category_rounded),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  openRazorpay();
                }, // Call the openRazorpay function
                label: Text(
                  "Buy",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                ),
              )
          ],
        ),
      ),
    ));
  }
}
