import 'package:flutter/material.dart';
import 'package:frontend/features/auth/screens/auth_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const auth = '/auth';
}
final getPages = [
  GetPage(
    name: AppRoutes.auth,
    page: () =>  AuthScreen(),
  ),
];

