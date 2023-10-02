import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wood_stockpile/wood_seller_dashboard/furniture_details.dart';

class Newproduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _newproduct();
  }
}

class _newproduct extends State<Newproduct> {
  void btnclick() {}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
      appBar: AppBar(
        title: Text("Wood StockPile"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select product Category",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    elevation: 50,
                    shadowColor: Colors.black,
                    color: const Color.fromARGB(255, 254, 254, 254),
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          furniture_details()));
                            },
                            icon: Lottie.asset("assets/lottie/furniture.json"),
                            iconSize: 100,
                          ),
                          Text("Furniture")
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    elevation: 50,
                    shadowColor: Colors.black,
                    color: const Color.fromARGB(255, 254, 254, 254),
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Lottie.asset("assets/lottie/woodsize.json"),
                            iconSize: 100,
                          ),
                          Text("Wood Size")
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
