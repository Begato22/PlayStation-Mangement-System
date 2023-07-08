import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playstation/Modules/signUp%20screen/sign_up_screen.dart';
import 'package:playstation/layouts/home%20layout/bloc/cubit.dart';
import 'package:playstation/layouts/home%20layout/bloc/states.dart';
import 'package:playstation/layouts/home%20layout/home_page.dart';
import 'package:playstation/shared/components/components.dart';
import '../../shared/Materials/material_app.dart';

import '../../shared/local/cash_helper.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // CashHelper.setData(key: 'isLogin', value: true);

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
                      defaultTextField(
                        textEditingController: emailController,
                        label: 'User Name',
                        textInputType: TextInputType.text,
                        prefix: Icons.person,
                      ),
                      const SizedBox(height: 10),
                      defaultTextField(
                        textEditingController: passwordController,
                        label: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        prefix: Icons.security,
                        obscureText: cubit.isHidden,
                        sufix: cubit.passwordVisibilityIcon,
                        sufixOnTap: () => cubit.changeVisibility(),
                      ),
                      defaultButton(
                        label: 'login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            log("object ${formKey.currentState!.validate()}");
                            if (emailController.text == 'es12' && passwordController.text == '123456') {
                              CashHelper.setData(key: 'isLogin', value: true).then((value) {
                                navigateAndRemoveTo(context, const HomeScreen());
                              });
                            } else {
                              log('incorrect ${emailController.text}  ${passwordController.text}');
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
                      customDividerText('or'),
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
