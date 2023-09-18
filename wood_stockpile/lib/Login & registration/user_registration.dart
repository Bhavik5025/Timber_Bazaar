import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wood_stockpile/Login%20&%20registration/login.dart';

final _firebase = FirebaseAuth.instance;

class userregistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _userregistration();
  }
}

class _userregistration extends State<userregistration> {
  var email = "";
  var password = "";
  var phone = "";
  var temp = "";
  var isupload = false;
  // ignore: non_constant_identifier_names
  var confirm_password = "";
  var uname = "";
  //create variable of form key and assign in key
  final _formkey = GlobalKey<FormState>();
  Future<void> setEmailVerification(BuildContext context) async {
    try {
      _firebase.currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email Verification Sent !')));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  void btn() async {
    final isvalid = _formkey.currentState!.validate();

    if (!isvalid) {
      //show error message....
      return;
    }

    _formkey.currentState!.save();

    try {
      setState(() {
        isupload = true;
      });
      final uc = await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);
      setEmailVerification(context);
      await FirebaseFirestore.instance
          .collection('unverified_users')
          .doc(uc.user!.uid)
          .set({
        'username': uname,
        'email': email,
        'mobile_number': phone,
        'password': password,
        'type': "user",
      });
      print(uc);
      setState(() {
        isupload = false;
        // final snackBar = SnackBar(
        //   content: Text('user created successfully!'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop(PageRouteBuilder(
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
              return login();
            }));
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        //...
      }
      print('FirebaseAuthException occurred: ${error.code}');
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'authentication failed.')));
      setState(() {
        isupload = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 26,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Lottie.asset("assets/lottie/registration.json", height: 250),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 25.0),
                  ],
                ),
                child: Container(
                    color: const Color.fromARGB(255, 237, 235, 235),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Name",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().length < 4) {
                                  return "please Enter the Name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                uname = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Mobile No.",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                final RegExp phoneRegex = RegExp(r'^\d{10}$');

                                if (!phoneRegex.hasMatch(value!)) {
                                  return 'Please enter a valid 10-digit mobile number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                phone = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Email",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains("@")) {
                                  return "please enter valid email address";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                email = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Password",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                              obscureText: true,
                              validator: (value) {
                                temp = value!;
                                print(value);
                                if (value.isEmpty || value.trim().length < 6) {
                                  return "password must be 6 character long";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                password = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Confirm password",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return "password must be 6 character long";
                                }
                                if (value != temp) {
                                  print(value);
                                  print(password);
                                  return "password and confirm password are not same";
                                }

                                return null;
                              },
                              onSaved: (value) {
                                confirm_password = value!;
                              },
                            ),
                          ),
                          if (isupload)
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            ),
                          if (!isupload)
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                width: 170,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: btn,
                                    child: Text(
                                      "Register",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.black, // background color
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    )),
                              ),
                            ),
                        ],
                      ),
                    )),
              ),
            ),
          ]),
        ));
  }
}
