import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wood_stockpile/user_dashboard/Profile.dart';
import 'package:wood_stockpile/user_dashboard/Screen_1.dart';
import 'package:wood_stockpile/user_dashboard/orders.dart';
import 'package:wood_stockpile/user_dashboard/products.dart';
import 'package:wood_stockpile/user_dashboard/woods_search.dart';

class Homescreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homescreen();
  }
}

class _homescreen extends State<Homescreen> {
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    Screen_1(),
    products(),
    woodsearch(),
    orders(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wood StockPile"),
        backgroundColor: Colors.black,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: false,
              notchColor: Colors.black87,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 300,
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  itemLabel: 'Page 1',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.table_restaurant_rounded,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.chair_alt,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  itemLabel: 'Page 2',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.woo_commerce_rounded,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.woo_commerce_rounded,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  itemLabel: 'Page 3',
                ),

                ///svg example
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.fire_truck,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.fire_truck,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 4',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  itemLabel: 'Page 5',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                // log('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}
