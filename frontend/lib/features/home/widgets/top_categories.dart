import 'package:flutter/material.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_text.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.h(100),
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(50),
                child: Image.asset(
                  GlobalVariables.categoryImages[index]['image']!,
                  fit: BoxFit.cover,
                  height: AppSize.h(55),
                  width: AppSize.w(50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: AppText.caption(
                GlobalVariables.categoryImages[index]['title']!,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
