import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static pushNamedAndRemoveUntil(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  static unfocusKeyboard() {
    FocusScope.of(navigatorKey.currentContext!).unfocus();
  }
}
