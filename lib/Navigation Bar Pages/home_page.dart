import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:playstation/Materials/material_app.dart';
import 'package:playstation/Navigation%20Bar%20Pages/account.dart';
import 'package:playstation/Navigation%20Bar%20Pages/home.dart';
import 'package:playstation/Navigation%20Bar%20Pages/online.dart';
import 'package:playstation/Navigation%20Bar%20Pages/setting.dart';
import 'package:playstation/Navigation%20Bar%20Pages/rooms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
int _page = 0;
final screens = [
  const Home(),
  const OnlinePage(),
  const RoomsPage(),
  const AccountPage(),
  const SettingPage(),
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: MaterialPSApp.whiteColor,
        buttonBackgroundColor: MaterialPSApp.backgroundColor,
        color: MaterialPSApp.basicColor,
        height: 50,
        animationDuration: const Duration(milliseconds: 200),
        items: const <Widget>[
          Icon(Icons.home, size: 25, color: MaterialPSApp.whiteColor),
          Icon(Icons.online_prediction,
              size: 25, color: MaterialPSApp.whiteColor),
          Icon(MaterialPSApp.playstationIcon,
              color: MaterialPSApp.whiteColor),
          Icon(Icons.person, size: 25, color: MaterialPSApp.whiteColor),
          Icon(Icons.settings, size: 25, color: MaterialPSApp.whiteColor),
        ],
        index: _page,
        onTap: (index) {
          setState(() {
            _page = index;
            print("pageeeeeeeeeeeeeeeeeee $_page");
          });
        },
      ),
      body: screens[_page],
    );
  }
}
