import 'package:flutter/material.dart';

import 'my_flutter_app_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialPSApp {
  //Colors
  static const Color backgroundColor = Color.fromARGB(255, 43, 41, 46);
  static const Color basicColor = Color.fromARGB(255, 61, 216, 200);
  static const Color whiteColor = Colors.white;

  //Logo Image
  static Image logo = Image.asset("assets/logo/logo.png");

  //Icons
  static const IconData playstationIcon = MyFlutterApp.playstation;

  //TextStyle
  static TextStyle logoFontO =
      GoogleFonts.titanOne(fontSize: 20, color: MaterialPSApp.basicColor);
  static const TextStyle titleFontO = TextStyle(
      fontSize: 20,
      color: MaterialPSApp.basicColor,
      decoration: TextDecoration.none,
      fontFamily: "Arial Rounded Bold");
  static const TextStyle titleFontB = TextStyle(
      fontSize: 30,
      color: MaterialPSApp.backgroundColor,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      fontFamily: "Arial Rounded Bold");
  static const TextStyle basicFontO = TextStyle(
      fontSize: 14,
      color: MaterialPSApp.basicColor,
      decoration: TextDecoration.none,
      fontFamily: "Arial Rounded");
  static const TextStyle basicFontW = TextStyle(
      fontSize: 14,
      color: MaterialPSApp.whiteColor,
      decoration: TextDecoration.none,
      fontFamily: "Arial Rounded");
  static const TextStyle buttonsFontW = TextStyle(
      fontSize: 14,
      color: MaterialPSApp.whiteColor,
      decoration: TextDecoration.none,
      fontFamily: "Arial Rounded");
}
