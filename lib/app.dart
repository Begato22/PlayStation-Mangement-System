import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playstation/layouts/home%20layout/bloc/cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PlaystationHomeCubit()..createDatabase(),
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
