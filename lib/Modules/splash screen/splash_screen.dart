import 'package:flutter/material.dart';

import 'package:easy_splash_screen/easy_splash_screen.dart';

import '../../shared/Materials/material_app.dart';
import '../login screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        "assets/logo/logo.png",
        fit: BoxFit.cover,
      ),
      logoSize: 110,
      backgroundColor: MaterialPSApp.backgroundColor,
      showLoader: true,
      loaderColor: MaterialPSApp.basicColor,
      loadingText: const Text(
        "Loading...",
        style: MaterialPSApp.basicFontO,
      ),
      // navigator: const LogInPage(),
      navigator: LogInScreen(),
      durationInSeconds: 5,
    );
  }
}
