import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

class SearchServices {
  // To fetch all the Search
  Future<List<Product>> fetchSearchProduct(
    BuildContext context,
    String searchQuery,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$baseUrl/api/products/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
      );
      HttpErrorHandling(
        response: res,
        onSuccess: () {
          final List data = jsonDecode(res.body);
          for (int i = 0; i < data.length; i++) {
            productList.add(Product.fromJson(jsonEncode(data[i])));
          }
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackbar(e.toString());
    }
    return productList;
  }
}
