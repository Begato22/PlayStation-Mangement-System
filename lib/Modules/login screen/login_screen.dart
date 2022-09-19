// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playstation/Modules/signUp%20screen/signup_screen.dart';
import 'package:playstation/layouts/home%20layout/bloc/cubit.dart';
import 'package:playstation/layouts/home%20layout/bloc/states.dart';
import 'package:playstation/layouts/home%20layout/home_page.dart';
import 'package:playstation/shared/componentes/components.dart';
import '../../shared/Materials/material_app.dart';

import '../../shared/local/cach_helper.dart';

class LogInScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CashHelper.setData(key: 'islogin', value: true);

    return BlocConsumer<PlaystationHomeCubit, PlaystationHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PlaystationHomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color.fromRGBO(250, 250, 250, 255),
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: const Color.fromRGBO(250, 250, 250, 255),
            elevation: 0,
          ),
          body: buildBackgroundContainer(
            context: context,
            child: Container(
              padding: MediaQuery.of(context).padding,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo/logo.png",
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "LogIn",
                          style: MaterialPSApp.titleFontB,
                        ),
                      ),
                      const SizedBox(height: 15),
                      defultTextFeild(
                        textEditingController: emailController,
                        label: 'User Name',
                        textInputType: TextInputType.text,
                        prefix: Icons.person,
                      ),
                      const SizedBox(height: 10),
                      defultTextFeild(
                        textEditingController: passwordController,
                        label: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        prefix: Icons.security,
                        obscureText: cubit.isHidden,
                        sufix: cubit.passwordVisabilityIcon,
                        sufixOnTap: () => cubit.changeVisibility(),
                      ),
                      defultButton(
                        label: 'login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print("object ${formKey.currentState!.validate()}");
                            if (emailController.text == 'es12' &&
                                passwordController.text == '123456') {
                              CashHelper.setData(key: 'islogin', value: true)
                                  .then((value) {
                                navigateAndRemoveTo(context, const HomePage());
                              });
                            } else {
                              print(
                                  'incorrect ${emailController.text}  ${passwordController.text}');
                              showToast(
                                'Your Email or Password may be incorrect',
                                ToastState.error,
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      customDividorText('or'),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, SignUpScreen());
                        },
                        child: const Text(
                          "Create new Account ?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
