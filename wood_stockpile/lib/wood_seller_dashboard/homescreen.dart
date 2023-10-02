import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wood_stockpile/wood_seller_dashboard/Wood_Profile.dart';
import 'package:wood_stockpile/wood_seller_dashboard/product.dart';

class homescreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homescreen();
  }
}

class _homescreen extends State<homescreen> {
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
    product(),
    const Page2(),
    const Page3(),
    const Page4(),
    Wood_profile(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
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
                    Icons.star,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 2',
                ),

                ///svg example
                BottomBarItem(
                  inActiveItem: Lottie.asset(
                    'assets/lottie/network-error.json',
                  ),
                  activeItem: Lottie.asset(
                    'assets/lottie/network-error.json',
                  ),
                  itemLabel: 'Page 3',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.settings,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.settings,
                    color: Colors.pink,
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
                    color: Colors.yellow,
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
    ));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green, child: const Center(child: Text('Page 2')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red, child: const Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue, child: const Center(child: Text('Page 4')));
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreenAccent,
        child: const Center(child: Text('Page 5')));
  }
}
