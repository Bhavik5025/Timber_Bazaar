

import 'package:admin_wood/home_screens/TabBar.dart';
import 'package:admin_wood/home_screens/home.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class wood_seller_view extends StatefulWidget {
  wood_seller_view({
    super.key,
    required this.companyname,
    required this.certificate,
    required this.address,
    required this.mobile_no,
    required this.latitude,
    required this.longitude,
    required this.email,
    required this.uid,
    required this.images,
    required this.verified,
  });
  var companyname = "";
  var password = "";
  var uid = "";
  var certificate = "";
  var address = "";
  var mobile_no = "";
  var email = "";
  var latitude = "";
  var longitude = "";
  var verified = "";
  List<dynamic> images;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _wood();
  }
}

class _wood extends State<wood_seller_view> {
  GoogleMapController? mapController;
  var isverify = false;
  Set<Marker> markers1 = {};
  double lat = 0;
  double long = 0;
  List<dynamic> img = [];

  void marker() async {
    print("bhavik");
    print(widget.uid);
    lat = double.parse(widget.latitude);
    long = double.parse(widget.longitude);

    markers1 = {
      Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(lat, long), // Location 1
        infoWindow: InfoWindow(title: widget.companyname),
      ),
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marker();
  }

  void Reject() async {
    setState(() {
      isverify = true;
    });
    await FirebaseFirestore.instance
        .collection('unverified_wood_seller')
        .doc(widget.uid)
        .delete();

    final smtpServer = gmail('bhavik5033@gmail.com', 'gpkfprebinnhmzqh');
    final message = Message()
      ..from = Address('bhavik5033@gmail.com', 'Wood StockPile Admin')
      ..recipients
          .add(widget.email) // Replace with the recipient's email address
      ..subject = 'Wood StockPile :: ${DateTime.now()}'
      ..text = 'Regarding verification.\n\n'
      ..html =
          "<h1>Authentication</h1>\n<p>Sorry, you have not been verified by the admin. Please provide valid data.</p>\n<p>Thank you...</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
      setState(() {
        isverify = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => tabbar()));
    } on MailerException catch (e) {
      print('Message not sent.\n${e.toString()}');
      isverify = false;
    }
  }

  void approve() async {
    setState(() {
      isverify = true;
    });
    await FirebaseFirestore.instance
        .collection('wood_seller')
        .doc(widget.uid)
        .set({
      'uid': widget.uid,
      'Company_name': widget.companyname,
      'email': widget.email,
      'Mobile_no': widget.mobile_no,
      'Address': widget.address,
      'certificate': widget.certificate,
      'type': 'wood_seller',
      'images': widget.images,
      'verified': 'yes',
      'latitude': lat,
      'longitude': long
    });
    await FirebaseFirestore.instance.collection('users').doc(widget.uid).set({
      'uid': widget.uid,
      'Company_name': widget.companyname,
      'email': widget.email,
      'Mobile_no': widget.mobile_no,
      'Address': widget.address,
      'certificate': widget.certificate,
      'images': widget.images,
      'type': 'wood_seller',
      'verified': 'yes',
      'latitude': lat,
      'longitude': long
    });
    await FirebaseFirestore.instance
        .collection('unverified_wood_seller')
        .doc(widget.uid)
        .delete();

    final smtpServer = gmail('bhavik5033@gmail.com', 'gpkfprebinnhmzqh');
    final message = Message()
      ..from = Address('bhavik5033@gmail.com', 'Wood StockPile Admin')
      ..recipients
          .add(widget.email) // Replace with the recipient's email address
      ..subject = 'Wood StockPile  :: ${DateTime.now()}'
      ..text = 'Regarding verification.\n'
      ..html =
          "<h1>Authentication</h1>\n<p>Congratulations,You are verify by Admin.Now you can login to the System.</p>\n<p>Thank you...</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
      setState(() {
        isverify = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => tabbar()));
    } on MailerException catch (e) {
      print('Message not sent.\n${e.toString()}');
      isverify = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Wood StockPile"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    widget.certificate,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.companyname,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  "Address",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 25,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.address,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat, long),
                      // San Francisco
                      zoom: 16.0,
                    ),
                    markers: markers1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Company Images",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 25,
                          fontWeight: FontWeight.w800),
                    ),
                    Container(
                      height: 400,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            for (String imageUrl in widget.images)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image.network(imageUrl),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  "Mobile No.",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 25,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      widget.mobile_no,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                          onPressed: () {
                            UrlLauncher.launch('tel:+91${widget.mobile_no}');
                          },
                          icon: Icon(Icons.phone_rounded)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  "Email id",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 25,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.email,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              if (isverify)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  )),
                ),
              if (!isverify && widget.verified == "no")
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: approve,
                          icon: Icon(Icons.approval),
                          label: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, top: 10, left: 5),
                            child: Text(
                              "Approve",
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: Reject,
                          icon: Icon(Icons.remove_circle_outline),
                          label: Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 10, bottom: 10, top: 10),
                            child: Text(
                              "Reject",
                              style: TextStyle(fontSize: 20),
                            ),
                          ))
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
