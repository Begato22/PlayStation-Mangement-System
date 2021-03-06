import 'package:flutter/material.dart';
import 'package:playstation/Materials/material_app.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: Container(
            margin: EdgeInsets.only(bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo/logo.png",
                  width: 150,
                  height: 150,
                ),
                Text(
                  "Kazablanka PS",
                  style: MaterialPSApp.logoFontO,
                ),
              ],
            ),
            height: 1000,
            width: double.infinity,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey, spreadRadius: 10, blurRadius: 20),
              ],
              color: MaterialPSApp.backgroundColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "LogIn",
                    style: MaterialPSApp.titleFontB,
                  )),
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email:',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.security),
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password:',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home-page');
                  },
                  child: const Text(
                    "LOGIN",
                    style: MaterialPSApp.buttonsFontW,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(children: const <Widget>[
                Expanded(child: Divider(thickness: 2)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("OR"),
                ),
                Expanded(child: Divider(thickness: 2)),
              ]),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup-page');
                  },
                  child: const Text(
                    "Create new Account ?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
