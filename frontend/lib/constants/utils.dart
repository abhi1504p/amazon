import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
    );
    if (result != null && result.files.isNotEmpty) {
      for (int i = 0; i < result.files.length; i++) {
        images.add(File(result.files[i].path!));
      }
    }
  } catch (e) {
     debugPrint(e.toString());
  }
  return images;
}
