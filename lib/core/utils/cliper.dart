import 'package:flutter/material.dart';

class AuthenticationClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.7566667);
    path0.quadraticBezierTo(size.width * 0.1016667, size.height * 0.9300000,
        size.width * 0.2466667, size.height * 0.9166667);
    path0.quadraticBezierTo(size.width * 0.5183333, size.height * 0.8808333,
        size.width, size.height * 0.3333333);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
