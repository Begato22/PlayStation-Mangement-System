import 'package:flutter/material.dart';
import 'package:playstation/Materials/material_app.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
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
                  width: 100,
                  height: 100,
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
        margin: EdgeInsets.symmetric(horizontal: 7.5),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "SignUp",
                    style: MaterialPSApp.titleFontB,
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7.5),
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'First Name:',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.name,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7.5),
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Last Name:',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.name,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7.5),
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email:',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7.5),
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Mobile Number:',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7.5),
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
                margin: EdgeInsets.symmetric(vertical: 7.5),
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.security),
                    border: OutlineInputBorder(),
                    labelText: 'Confirm your Password',
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
                  onPressed: () {},
                  child: const Text(
                    "SUBMIT",
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
                  onPressed: () {Navigator.pushReplacementNamed(context, '/login-page');},
                  child: const Text(
                    "You have already Account ?",
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
