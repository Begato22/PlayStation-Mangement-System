import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:playstation/Materials/material_app.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: const Center(
        child: Text("Account Page", style: MaterialPSApp.titleFontO),
      ),
    );
  }
}
