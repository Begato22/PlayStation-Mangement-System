import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:playstation/Materials/material_app.dart';

class OnlinePage extends StatelessWidget {
  const OnlinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _page = 0;
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Rooms"),
      ),
      body: const Center(
        child:  Text("Online Page",style: MaterialPSApp.titleFontO,),
      ),
    );
  }
}
