// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playstation/Modules/login%20screen/login_screen.dart';
import 'package:playstation/layouts/home%20layout/bloc/cubit.dart';
import 'package:playstation/layouts/home%20layout/bloc/states.dart';
import 'package:playstation/shared/components/components.dart';
import 'package:playstation/shared/local/cash_helper.dart';
import '../../shared/Materials/material_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CashHelper.setData(key: 'isLast', value: 'homeLayout');
    return BlocConsumer<PlaystationHomeCubit, PlaystationHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PlaystationHomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.teal, statusBarIconBrightness: Brightness.light),
            title: Row(
              children: [
                Image.asset(
                  'assets/logo/logo.png',
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 5),
                Text(cubit.screensTitle[cubit.currentPage]),
              ],
            ),
            actions: [
              if (cubit.currentPage == 4)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      const Text('logout'),
                      IconButton(
                        onPressed: () {
                          CashHelper.removeData(key: 'islogin').then(
                            (value) {
                              if (value) {
                                navigateAndRemoveTo(context, const LogInScreen());
                                cubit.currentPage = 2;
                              }
                            },
                          );
                        },
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
              if (cubit.currentPage == 3)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                      onPressed: () async {
                        if (cubit.history.isEmpty) {
                          showToast('no session to be deleted !', ToastState.warning);
                        } else {
                          showDialogAlert(
                            context: context,
                            message: "Are you sure you want to delete all history ?",
                            url: 'clear',
                            needCancel: true,
                            onOk: () => PlaystationHomeCubit.get(context).deleteAllHistoryFromDatabase(),
                          );
                        }
                      },
                      child: const Text(
                        "Clear",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                )
            ],
          ),
          body: cubit.screens[cubit.currentPage],
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: !cubit.show
                ? const Color.fromARGB(250, 250, 250, 255)
                : cubit.currentPage == 2
                    ? const Color.fromRGBO(238, 238, 238, 1)
                    : const Color.fromARGB(250, 250, 250, 255),
            buttonBackgroundColor: MaterialPSApp.backgroundColor,
            color: MaterialPSApp.basicColor,
            height: 50,
            animationDuration: const Duration(milliseconds: 200),
            items: cubit.navigationBarItem,
            index: cubit.currentPage,
            onTap: (index) => cubit.changeNavigationBarPage(index),
          ),
        );
      },
    );
  }
}
