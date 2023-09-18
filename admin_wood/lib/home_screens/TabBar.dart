import 'package:admin_wood/home_screens/profile.dart';
import 'package:admin_wood/home_screens/tabstate.dart';
import 'package:flutter/material.dart';

class tabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text("Wood StockPile"),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              dividerColor: Colors.transparent,
              tabs: <Widget>[
                Tab(
                  text: 'Home',
                  icon: Icon(Icons.home_outlined),
                ),
                Tab(
                  text: 'Profile',
                  icon: Icon(Icons.person_2_outlined),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[NestedTabBar('Home'), outer('profile')],
          ),
        ));
  }
}
