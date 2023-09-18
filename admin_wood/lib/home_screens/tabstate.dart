import 'package:admin_wood/home_screens/verification_wood.dart';
import 'package:admin_wood/home_screens/verified_wood_seller_view.dart';
import 'package:flutter/material.dart';

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          TabBar.secondary(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: "varification"),
              Tab(text: 'Verified Wood Sellers'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.all(16.0),
                  child: v_wood(),
                ),
                Card(
                    margin: const EdgeInsets.all(16.0),
                    child: Center(
                      child: verified_wood_seller(),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
