// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playstation/Modules/login%20screen/login_screen.dart';
import '../../layouts/home layout/bloc/cubit.dart';
import '../../layouts/home layout/bloc/states.dart';
import '../../shared/Materials/material_app.dart';
import '../../shared/components/components.dart';

class SignUpScreen extends StatelessWidget {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaystationHomeCubit, PlaystationHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PlaystationHomeCubit.get(context);
        return Scaffold(
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
                          "SignUp",
                          style: MaterialPSApp.titleFontB,
                        ),
                      ),
                      const SizedBox(height: 15),
                      defaultTextField(
                        textEditingController: userNameController,
                        label: 'User Name',
                        textInputType: TextInputType.text,
                        prefix: Icons.person,
                      ),
                      const SizedBox(height: 10),
                      defaultTextField(
                        textEditingController: emailController,
                        label: 'Email',
                        textInputType: TextInputType.emailAddress,
                        prefix: Icons.email,
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
                      const SizedBox(height: 10),
                      defaultTextField(
                        textEditingController: emailController,
                        label: 'Phone',
                        textInputType: TextInputType.number,
                        prefix: Icons.phone,
                      ),
                      defaultButton(
                        label: 'submit',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            navigateAndRemoveTo(context, const LogInScreen());
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      customDividerText('or'),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, const LogInScreen());
                        },
                        child: const Text(
                          "You have already account ?",
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
