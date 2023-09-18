import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class lottie_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromARGB(255, 255, 255, 255)),
      child: Column(
        children: [
          Lottie.asset("assets/lottie/wood.json", height: 300, width: 300),
          FutureBuilder(
            future: Future.delayed(Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                return animatedtext(); // Show animated text after the delay
              }
              return sizebo();
            },
          )
        ],
      ),
    );
  }
}

class sizebo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 2,
    );
  }
}

class animatedtext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          "Wood StockPile",
          textStyle: TextStyle(
              fontSize: 30,
              fontFamily: 'Bobbers',
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 71, 0, 0)),
        )
      ],
      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 2000),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}
