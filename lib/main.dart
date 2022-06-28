import 'package:flutter/material.dart';

import 'package:playstation/LogIn%20Page/login_page.dart';
import 'package:playstation/Navigation%20Bar%20Pages/account.dart';
import 'package:playstation/PageView/page_view.dart';

import 'Navigation Bar Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/account': (context) => const AccountPage(),
      },
    );
  }
}
