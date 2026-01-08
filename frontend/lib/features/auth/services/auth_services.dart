import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Sign Up the User
  void signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "user",
        token: '',
      );
      var url = Uri.parse('$baseUrl/api/signup');
      http.Response res = await http.post(
        url,
        body: user.toJson(),
        headers: {'Content-Type': 'application/json'},
      );
      HttpErrorHandling(
        response: res,
        onSuccess: () async => {
          showSnackbar(
            "Account Created",
            title: "Success",
            backgroundColor: Colors.greenAccent,
            icon: Icons.check_box,
          ),
        },
      );
    } catch (e) {
      showSnackbar(e.toString());
    }
  }

  // Sign In the user
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/api/signIn');

      final res = await http.post(
        url,
        body: jsonEncode({"email": email, "password": password}),
        headers: {'Content-Type': 'application/json'},
      );

      Map<String, dynamic> responseData = {};

      HttpErrorHandling(
        response: res,
        onSuccess: () async {
          responseData = jsonDecode(res.body);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', responseData['token']);
        },
      );

      return responseData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // get the user data
  void getUserData({BuildContext? context}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');
      if (token == null) {
        pref.setString('x-auth-token', '');
      }
      final url = Uri.parse('$baseUrl/tokenIsValid');
      var tokenRes = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'x-auth-token': token!},
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //   get user data
        final url = Uri.parse('$baseUrl/');
        http.Response userRes = await http.get(
          url,
          headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        );

        if (context != null && context.mounted) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);

          userProvider.setUser(userRes.body);
        }
      }
    } catch (e) {
      print(e);
      showSnackbar(e.toString());
    }
  }
}
