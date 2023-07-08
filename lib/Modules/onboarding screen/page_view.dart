import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playstation/Modules/splash%20screen/splash_screen.dart';
import 'package:playstation/shared/components/components.dart';
import 'package:playstation/shared/local/cash_helper.dart';
import '../../shared/Materials/material_app.dart';

import 'page_view_element.dart';
import 'pv_indicator.dart';

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
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < 3) {
        _currentIndex++;
        _controller.animateToPage(_currentIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
    super.initState();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MaterialPSApp.backgroundColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: MaterialPSApp.backgroundColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        children: [
          //Page View
          PageView(
            controller: _controller,
            onPageChanged: (val) {
              setState(() {
                _currentIndex = val;
              });
              if (_currentIndex == 2) {
                Future.delayed(
                  const Duration(seconds: 5),
                  () {
                    CashHelper.setData(key: 'onBorderFinish', value: true).then((value) {
                      if (value) {
                        log("isOnBorderFinish in Mani: ${CashHelper.getData(key: 'onBorderFinish')}");
                        navigateAndRemoveTo(context, const SplashScreen());
                      }
                    });
                  },
                );
              }
            },
            children: [
              PageViewElement(
                      title: "Mobile Analytics",
                      description: "Lorem Ipsum is simply dummy text of the logging and typesetting industry.",
                      imagePath: "assets/unDraw/mobile_analytics.png")
                  .getPageViewElement(),
              PageViewElement(
                      title: "Schedule",
                      description: "when an unknown logger took a galley of type and scrambled it to make a type specimen book.",
                      imagePath: "assets/unDraw/Schedule.png")
                  .getPageViewElement(),
              PageViewElement(
                      title: "Having Fun",
                      description: "It has survived not only five centuries, but also the leap into electronic typesetting.",
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
                  CashHelper.setData(key: 'onBorderFinish', value: true).then((value) {
                    if (value) {
                      log("isOnBorderFinish in Mani: ${CashHelper.getData(key: 'onBorderFinish')}");
                      navigateAndRemoveTo(context, const SplashScreen());
                    }
                  });
                },
                child: const Text(
                  "GET STARTED",
                  style: MaterialPSApp.buttonsFontW,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
