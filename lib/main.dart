// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playstation/layouts/home%20layout/bloc/cubit.dart';
import 'package:playstation/shared/local/cach_helper.dart';
import 'package:playstation/shared/observabe.dart';

import 'Modules/boardering screen/page_view.dart';
import 'Modules/login screen/login_screen.dart';

import 'layouts/home layout/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.initi();
  bool? isOnBorderFinish = CashHelper.getData(key: 'onBorderFinish');
  bool? isLogin = CashHelper.getData(key: 'islogin');
  Widget widget = PageView();
  Bloc.observer = MyBlocObserver();
  if (isOnBorderFinish != null) {
    if (isLogin != null) {
      widget = const HomePage();
    } else {
      widget = LogInScreen();
    }
  } else {
    widget = const PageViewPS();
  }

  runApp(
    MyApp(
      widget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          PlaystationHomeCubit()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
            ),
          ),
        ),
        home: widget,
      ),
    );
  }
}
