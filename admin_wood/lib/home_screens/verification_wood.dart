import 'package:admin_wood/home_screens/wood_seller_view.dart';
import 'package:admin_wood/models/wood_seller.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class v_wood extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _v_wood();
  }
}

class _v_wood extends State<v_wood> {
  List<WoodSeller> woodsellers = [];
  void fetchwoodsellers() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var data = await FirebaseFirestore.instance
        .collection("unverified_wood_seller")
        .get();
    mapwoodseller(data);
  }

  mapwoodseller(QuerySnapshot<Map<String, dynamic>> document) {
    var w_list = document.docs
        .map((wlist) => WoodSeller(
            uid: wlist['uid'],
            companyName: wlist['Company_name'],
            email: wlist['email'],
            mobileNo: wlist['Mobile_no'],
            certificate: wlist['certificate'],
            type: wlist['type'],
            verified: wlist['verified'],
            address: wlist['Address'],
            latitude: wlist['latitude'],
            longitude: wlist['longitude']))
        .toList();
    setState(() {
      woodsellers.addAll(w_list);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchwoodsellers();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: woodsellers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(woodsellers[index].companyName.toString()),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(seconds: 2),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          animation = CurvedAnimation(
                              parent: animation, curve: Curves.elasticInOut);
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
                          return wood_seller_view(
                            companyname:
                                woodsellers[index].companyName.toString(),
                            certificate:
                                woodsellers[index].certificate.toString(),
                            address: woodsellers[index].address.toString(),
                            mobile_no: woodsellers[index].mobileNo.toString(),
                            email: woodsellers[index].email.toString(),
                            latitude: woodsellers[index].latitude.toString(),
                            longitude: woodsellers[index].longitude.toString(),
                            uid: woodsellers[index].uid.toString(),
                            verified: "no",
                          );
                        }));
              },
              child: Text("View"),
            ),
          );
        });
  }
}
