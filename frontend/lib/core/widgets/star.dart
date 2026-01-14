import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/constants/global_variables.dart';

class Star extends StatelessWidget {
  final double rating;
  const Star({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemCount: 5,
      rating: rating,
      itemSize: 15,
      itemBuilder: (context, _) =>
          Icon(Icons.star, color: GlobalVariables.secondaryColor),
    );
  }
}
