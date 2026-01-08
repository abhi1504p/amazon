// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';

import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_input_field.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../../home/screens/home_screen.dart';
import '../services/auth_services.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUp(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() async {
    await authService.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.title("Welcome", fontSize: 22),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: AppText.title("Create Account"),
                leading: Radio(
                  value: Auth.signup,
                  activeColor: GlobalVariables.secondaryColor,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        SizedBox(height: 4),
                        AppInputField(
                          labeltext: "Name",
                          obscureTexts: false,
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          maxlines: 1,
                        ),
                        SizedBox(height: 6),
                        AppInputField(
                          labeltext: "Email",
                          obscureTexts: false,
                          keyboardType: TextInputType.text,
                          controller: _emailController,
                          maxlines: 1,
                        ),
                        SizedBox(height: 6),
                        AppInputField(
                          labeltext: "Password",
                          obscureTexts: true,
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          maxlines: 1,
                        ),
                        SizedBox(height: 15),
                        AppButton(
                          type: ButtonType.filled,
                          onPressed: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          text: "SignUp",
                          color: GlobalVariables.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),

              ListTile(
                title: AppText.title("Sign In"),
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                leading: Radio(
                  value: Auth.signin,
                  activeColor: GlobalVariables.secondaryColor,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        SizedBox(height: 2),
                        AppInputField(
                          labeltext: "Email",
                          obscureTexts: false,
                          keyboardType: TextInputType.text,
                          controller: _emailController,
                          maxlines: 1,
                        ),
                        SizedBox(height: 6),
                        AppInputField(
                          labeltext: "Password",
                          obscureTexts: true,
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          maxlines: 1,
                        ),
                        SizedBox(height: 15),
                        AppButton(
                          type: ButtonType.filled,
                          onPressed: () async {
                            final resBody = await AuthService().signIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (!context.mounted) return;
                            context.read<UserProvider>().setUser(
                              jsonEncode(resBody),
                            );
                            if (!context.mounted) return;

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.routeName,
                              (route) => false,
                            );
                          },
                          text: "SignIn",
                          color: GlobalVariables.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
