import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_input_field.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:frontend/features/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            final auth = authController.selectedAuth.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.title("Welcome", fontSize: 22),
                ListTile(
                  tileColor: auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: AppText.title("Create Account"),
                  leading: Radio(
                    value: Auth.signup,
                    activeColor: GlobalVariables.secondaryColor,
                    groupValue: auth,
                    onChanged: (Auth? val) {
                      authController.selectedAuth.value = val!;
                    },
                  ),
                ),
                if (auth == Auth.signup)
                  Container(
                    padding: EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signupFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 4),
                          AppInputField(
                            labeltext: "Name",
                            obscureTexts: false,
                            keyboardType: TextInputType.text,
                            controller: authController.nameController,
                            maxlines: 1,
                          ),
                          SizedBox(height: 6),
                          AppInputField(
                            labeltext: "Email",
                            obscureTexts: false,
                            keyboardType: TextInputType.text,
                            controller: authController.emailController,
                            maxlines: 1,
                          ),
                          SizedBox(height: 6),
                          AppInputField(
                            labeltext: "Password",
                            obscureTexts: true,
                            keyboardType: TextInputType.text,
                            controller: authController.passwordController,
                            maxlines: 1,
                          ),
                          SizedBox(height: 15),
                          AppButton(
                            type: ButtonType.filled,
                            onPressed: () {},
                            text: "SignUp",
                            color: GlobalVariables.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                ListTile(
                  title: AppText.title("Sign In"),
                  tileColor: auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  leading: Radio(
                    value: Auth.signin,
                    activeColor: GlobalVariables.secondaryColor,
                    groupValue: auth,

                    onChanged: (Auth? val) {
                      authController.selectedAuth.value = val!;
                    },
                  ),
                ),
                if (auth == Auth.signin)
                  Container(
                    padding: EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signinFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 2),
                          AppInputField(
                            labeltext: "Email",
                            obscureTexts: false,
                            keyboardType: TextInputType.text,
                            controller: authController.emailController,
                            maxlines: 1,
                          ),
                          SizedBox(height: 6),
                          AppInputField(
                            labeltext: "Password",
                            obscureTexts: true,
                            keyboardType: TextInputType.text,
                            controller: authController.passwordController,
                            maxlines: 1,
                          ),
                          SizedBox(height: 15),
                          AppButton(
                            type: ButtonType.filled,
                            onPressed: () {},
                            text: "SignIn",
                            color: GlobalVariables.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
