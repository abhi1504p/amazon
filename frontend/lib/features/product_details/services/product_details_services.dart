import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart' show showSnackbar;
import 'package:frontend/models/product.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/rate-product'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id':product.id!,
          'rating':rating,

        }),
      );
      HttpErrorHandling(
        response: res,
        onSuccess: () {

        },
      );
    } catch (e) {
      showSnackbar(e.toString());
    }

  }
}
