import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playstation/Materials/material_app.dart';
import 'package:playstation/PageView/page_view_element.dart';
import 'package:playstation/PageView/pv_indicator.dart';
import 'package:playstation/Splash%20Screen/splash_screen.dart';

class PageViewPS extends StatefulWidget {
  const PageViewPS({Key? key}) : super(key: key);

  @override
  State<PageViewPS> createState() => _PageViewPSState();
}

final PageController _controller = PageController(
  initialPage: 0,
);

class _PageViewPSState extends State<PageViewPS> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentIndex < 3) {
        _currentIndex++;
        _controller.animateToPage(_currentIndex,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Page View
        PageView(
          controller: _controller,
          onPageChanged: (val) {
            setState(() {
              _currentIndex = val;
            });
            if (_currentIndex == 2) {
              Future.delayed(const Duration(seconds: 5), () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => const SplashScreen())));
              });
            }
          },
          children: [
            PageViewElement(
                    title: "Mobile Analytics",
                    description:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    imagePath: "assets/unDraw/mobile_analytics.png")
                .getPageViewElement(),
            PageViewElement(
                    title: "Schedule",
                    description:
                        "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    imagePath: "assets/unDraw/Schedule.png")
                .getPageViewElement(),
            PageViewElement(
                    title: "Having Fun",
                    description:
                        "It has survived not only five centuries, but also the leap into electronic typesetting.",
                    imagePath: "assets/unDraw/Having_fun.png")
                .getPageViewElement(),
          ],
        ),
        //Page View Indicators
        Align(
          alignment: const Alignment(0, 0.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PVIndicator(isCurrent: _currentIndex == 0),
              PVIndicator(isCurrent: _currentIndex == 1),
              PVIndicator(isCurrent: _currentIndex == 2),
            ],
          ),
        ),
        //GET STARTED Button
        Align(
          alignment: const Alignment(0, 0.95),
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login-page');
                  },
                  child: const Text(
                    "GET STARTED",
                    style: MaterialPSApp.buttonsFontW,
                  ))),
        )
      ],
    );
  }
}
