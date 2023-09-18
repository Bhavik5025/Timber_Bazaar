import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:wood_stockpile/splash_screen/lottie_screen.dart';

import '../Login & registration/screen1.dart';

class splash_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _splash();
  }
}

class _splash extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: lottie_screen(),
        splashIconSize: 400,
        nextScreen: loginscreen(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        duration: 4000,
      ),
    );
  }
}
