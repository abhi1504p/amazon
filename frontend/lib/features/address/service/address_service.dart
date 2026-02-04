import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'address': address}),
      );

      HttpErrorHandling(
        response: res,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackbar(e.toString());
    }
  }

  // get all the products
  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': totalSum,
        }),
      );
      HttpErrorHandling(
        response: res,
        onSuccess: () {
          showSnackbar(
            'Your order has been placed!',
            title: "Success",
            backgroundColor: Colors.green,
            icon: Icons.check,
          );
          User user = userProvider.user.copyWith(cart: []);
          userProvider.setUserFromModel(user);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackbar(e.toString());
    }
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );
      HttpErrorHandling(
        response: res,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackbar(e.toString());
    }
  }
}
