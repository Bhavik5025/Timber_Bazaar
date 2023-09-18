import 'package:admin_wood/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class outer extends StatefulWidget {
  const outer(this.outertab, {super.key});
  final String outertab;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _outer();
  }
}

class _outer extends State<outer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Container(
            color: const Color.fromARGB(255, 237, 235, 235),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/image/profile.jpg'),
                    backgroundColor: Colors.white,
                    radius: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Admin name:-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text("  Bhavik Patel",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Email:-",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text("  bhavik0099@gmail.com",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => login())));
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
                    ],
                  ),
                )
              ],
            )));
  }
}
