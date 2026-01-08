import 'package:flutter/material.dart';

class SingleProductList extends StatelessWidget {
  final String image;
  const SingleProductList({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        width: 180,
        padding: EdgeInsets.all(10),
        child: Image.network(image, fit: BoxFit.fill),
      ),
    );
  }
}
