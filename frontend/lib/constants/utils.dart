import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(
    String text, {
      String title = "Error",
      Color backgroundColor = const Color(0xFFE53935),
      Color textColor = Colors.black,
      IconData icon = Icons.error_outline,
      SnackPosition position = SnackPosition.BOTTOM,
      Duration duration = const Duration(seconds: 5),
    }) {
  Get.snackbar(
    title,
    text,
    snackPosition: position,
    backgroundColor: backgroundColor,
    colorText: textColor,
    icon: Icon(icon, color: textColor),
    margin: const EdgeInsets.all(12),
    borderRadius: 10,
    duration: duration,
    isDismissible: true,
    shouldIconPulse: false,
  );
}


