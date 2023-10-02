import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wood_stockpile/Login%20&%20registration/login.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _profile();
  }
}

class _profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Center(
      child: ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => login())));
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "LogOut",
            style: TextStyle(fontSize: 20),
          ),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    ));
  }
}
