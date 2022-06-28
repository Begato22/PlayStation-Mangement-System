import 'package:flutter/material.dart';
import 'package:playstation/LogIn%20Page/login_page.dart';
import 'package:playstation/Materials/material_app.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        "assets/logo/logo.png",
        fit: BoxFit.cover,
      ),
      logoSize: 100,
      title: Text(
        "Kazablanka PlayStation",
        style: MaterialPSApp.logoFontO,
        textAlign: TextAlign.center,
      ),
      backgroundColor: MaterialPSApp.backgroundColor,
      showLoader: true,
      loaderColor: MaterialPSApp.basicColor,
      loadingText: const Text(
        "Loading...",
        style: MaterialPSApp.basicFontO,
      ),
      // navigator: const LogInPage(),
      navigator: const LogInPage(),
      durationInSeconds: 5,
    );
  }
}
