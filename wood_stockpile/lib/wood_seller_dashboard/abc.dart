import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/wood_seller.dart';

class ProductDisplay extends StatefulWidget {
  final String cId;
  final String pid;
  final String productName;
  final String category;
  final String price;
  final String productDescription;
  final String deliveryCharge;
  final List<String> productImages;

  ProductDisplay({
    Key? key,
    required this.cId,
    required this.pid,
    required this.productName,
    required this.category,
    required this.price,
    required this.deliveryCharge,
    required this.productDescription,
    required this.productImages,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PDisplay();
  }
}

class _PDisplay extends State<ProductDisplay> {
  double clet = 0.0;
  double clong = 0.0;
  double? mlet;
  double? mlong;
  GoogleMapController? _controller;
  WoodSeller? woodseller;

  void someMethod() {
    _controller?.animateCamera(CameraUpdate.newLatLng(
      LatLng(mlet ?? 0, mlong ?? 0),
    ));
  }

  void fetchCompany() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
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
          woodseller = wlist;
          clet = wlist.latitude;
          clong = wlist.longitude;
        });
      }
    } catch (e) {
      // Handle the error, e.g., show an error message to the user.
      print("Error fetching wood seller: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    someMethod();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    mlet = prefs.getDouble("let");
    mlong = prefs.getDouble("long");
    fetchCompany();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController(
      text: widget.productName,
    );

    return Scaffold(
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
                readOnly: true,
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
                readOnly: true,
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
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 200,
                child: GoogleMap(
                  key: const Key('YOUR_API_KEY'),
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(22.6708, 71.5724),
                    zoom: 15.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('Source'),
                      position: LatLng(mlet ?? 0, mlong ?? 0),
                      infoWindow: InfoWindow(title: 'Source'),
                    ),
                    if (woodseller != null)
                      Marker(
                        markerId: MarkerId('Destination'),
                        position: LatLng(clet, clong),
                        infoWindow: InfoWindow(title: 'Destination'),
                      ),
                  },
                  polylines: {
                    if (woodseller != null)
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
          ],
        ),
      ),
    );
  }
}
