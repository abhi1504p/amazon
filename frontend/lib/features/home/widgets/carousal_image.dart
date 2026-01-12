import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/constants/global_variables.dart';

class CarousalImage extends StatelessWidget {
  const CarousalImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageSliders,
      options: CarouselOptions(
        height: AppSize.h(200),
        viewportFraction: 1,
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
    );
  }
}

final List<Widget> imageSliders = GlobalVariables.carouselImages
    .map(
      (item) => Builder(
        builder: (context) {
          return Image.network(item, fit: BoxFit.fill);
        },
      ),
    )
    .toList();
