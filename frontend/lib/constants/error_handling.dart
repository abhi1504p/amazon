import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend/constants/utils.dart';
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
void HttpErrorHandling({
  required http.Response response,

  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackbar(jsonDecode(response.body)['msg']);

      break;
    case 500:
      showSnackbar(jsonDecode(response.body)['error']);
      break;
    default:
      showSnackbar(response.body);
  }
}
