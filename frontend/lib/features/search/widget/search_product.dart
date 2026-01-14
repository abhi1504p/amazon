import 'package:flutter/material.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:frontend/core/widgets/star.dart';
import 'package:frontend/models/product.dart';

class SearchProduct extends StatelessWidget {
  final Product product;
  const SearchProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: AppSize.h(135),
                width: AppSize.w(135),
              ),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      width: AppSize.w(235),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: AppText.body(product.name, maxLines: 2),
                    ),
                    Container(
                      width: AppSize.w(235),
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Star(rating: 3),
                    ),
                    Container(
                      width: AppSize.w(235),
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: AppText.body(
                        '\$${product.price}',
                        maxLines: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: AppSize.w(235),
                      padding: EdgeInsets.only(left: 10),
                      child: AppText.body(
                        'Eligible for Free Shipping',
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: AppSize.w(235),
                      padding: EdgeInsets.only(left: 10),
                      child: AppText.body(
                        'In Stock',
                        maxLines: 2,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
