import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/models/product.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required List<File> images,
    required String category,
  }) async {
    try {
      final cloudinary = CloudinaryPublic(
        dotenv.env['CLOUDINARY_NAME']!,
        dotenv.env['UPLOAD_PRESET']!,
        cache: false,
      );
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            resourceType: CloudinaryResourceType.Image,
            folder: name,
          ),
        );
        imageUrls.add(response.secureUrl);

        Product product = Product(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          images: imageUrls,
          category: category,
        );
      }
    } catch (e) {
      showSnackbar(e.toString());
    }
  }
}
