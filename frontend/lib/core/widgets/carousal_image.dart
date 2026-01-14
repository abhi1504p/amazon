import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarousalImage extends StatelessWidget {
  final BoxFit boxFit;
  final double height;
  final List<String> images;
  const CarousalImage({
    super.key,
    required this.images,
    required this.height,
     this.boxFit=BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images
          .map(
            (item) => Builder(
              builder: (context) {
                return Image.network(item, fit: boxFit);
              },
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: height,
        viewportFraction: 1,
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
    );
  }
}
