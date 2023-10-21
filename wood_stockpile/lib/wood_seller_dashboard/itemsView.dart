import 'package:flutter/material.dart';
import 'package:wood_stockpile/wood_seller_dashboard/product_list.dart';
import 'package:wood_stockpile/wood_seller_dashboard/wood_list.dart';

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Wood StockPile"),
          backgroundColor: Colors.black,
          bottom: const TabBar(
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.white,
                    width: 3.0), // Customize the color and width as needed
              ),
            ),
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.chair_alt_sharp),
                text: "Furniture",
              ),
              Tab(
                icon: Icon(Icons.woo_commerce_rounded),
                text: "Wood",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: product_list(),
            ),
            Center(
              child: Wood_list(),
            ),
          ],
        ),
      ),
    );
  }
}
