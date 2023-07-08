import 'package:flutter/material.dart';
import 'package:playstation/Modules/login%20screen/login_screen.dart';
import 'package:playstation/Modules/navigation%20bar%20screens/account_screen.dart';
import 'package:playstation/Modules/navigation%20bar%20screens/online_screen.dart';
import 'package:playstation/Modules/navigation%20bar%20screens/rooms_screen.dart';
import 'package:playstation/layouts/home%20layout/home_page.dart';

// import 'package:playstation/injection_container.dart' as di;

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String accountRoute = '/accountRoute';
  static const String onlineRoute = '/onlineRoute';
  static const String roomsRoute = '/roomsRoute';
}

class AppRoute {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LogInScreen(),
        );
      case Routes.accountRoute:
        return MaterialPageRoute(
          builder: (context) => const AccountScreen(),
        );
      case Routes.onlineRoute:
        return MaterialPageRoute(
          builder: (context) => const OnlineScreen(),
        );
      case Routes.roomsRoute:
        return MaterialPageRoute(
          builder: (context) => RoomsScreen(),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            'undefined Page :{',
          ),
        ),
      ),
    );
  }
}
