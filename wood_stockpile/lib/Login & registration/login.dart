import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wood_stockpile/Login%20&%20registration/user_registration.dart';
import 'package:wood_stockpile/Login%20&%20registration/wood_seller_registration.dart';

class login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _login();
  }
}

class _login extends State<login> {
  var email = "";
  var password = "";
  final _formkey = GlobalKey<FormState>();
  void btn() {
    final isvalid = _formkey.currentState!.validate();
    if (!isvalid) {
      //show error message....
      return;
    }

    _formkey.currentState!.save();
    print(email);
    print(password);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/login.json", height: 300),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Email",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
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
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return "password must be 6 character long";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password = value!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: btn,
                            child: const Text(
                              "login",
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, // background color
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("create a account as"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
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
                                          return userregistration();
                                        }));
                              },
                              icon: const Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                              label: const Text("user",
                                  style: TextStyle(color: Colors.black)),
                            ),
                            TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          transitionDuration:
                                              Duration(seconds: 2),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
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
                                            return wood_seller_registration();
                                          }));
                                },
                                icon: const Icon(
                                  Icons.business,
                                  color: Colors.black,
                                ),
                                label: const Text("Wood Seller",
                                    style: TextStyle(color: Colors.black))),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
