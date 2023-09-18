import 'package:admin_wood/home_screens/TabBar.dart';
import 'package:admin_wood/login/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _home();
  }
}

class _home extends State<home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: tabbar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
