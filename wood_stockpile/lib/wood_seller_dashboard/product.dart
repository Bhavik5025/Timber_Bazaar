import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wood_stockpile/wood_seller_dashboard/NewProduct.dart';
import 'package:wood_stockpile/wood_seller_dashboard/product_list.dart';

class product extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _product();
  }
}

class _product extends State<product> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Product",
              style: TextStyle(
                fontSize: 30, // Set the font size
                fontWeight: FontWeight.bold, // Set the font weight (e.g., bold)
                color: Colors.black,
              )),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: const Color.fromARGB(255, 254, 254, 254),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Newproduct()));
                          },
                          icon: Lottie.asset(
                            "assets/lottie/newproduct.json",
                          ),
                          iconSize: 100,
                        ),
                        Text("New")
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => product_list()));
                          },
                          icon: Lottie.asset(
                            "assets/lottie/history.json",
                          ),
                          iconSize: 100,
                        ),
                        const Text("History")
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
