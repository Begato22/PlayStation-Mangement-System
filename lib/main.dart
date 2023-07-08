// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:playstation/shared/local/cash_helper.dart';
import 'package:playstation/shared/observable.dart';

import 'Modules/onboarding screen/page_view.dart';
import 'Modules/login screen/login_screen.dart';

import 'layouts/home layout/home_page.dart';
import 'app.dart';
import 'package:playstation/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  bool? isOnBorderFinish = CashHelper.getData(key: 'onBorderFinish');
  bool? isLogin = CashHelper.getData(key: 'isLogin');
  Widget widget = PageView();
  Bloc.observer = MyBlocObserver();
  if (isOnBorderFinish != null) {
    if (isLogin != null) {
      widget = const HomeScreen();
    } else {
      widget = const LogInScreen();
    }
  } else {
    widget = const PageViewPS();
  }

  runApp(
    MyApp(widget: widget),
  );
}
