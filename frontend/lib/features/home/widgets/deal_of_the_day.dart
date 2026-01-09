import 'package:flutter/material.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/core/widgets/app_text.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsetsGeometry.only(left: 10),
          child: AppText.title(
            "Deal of the Day",
            fontSize: 21,
            fontWeight: FontWeight.w400,
          ),
        ),
        Image.network(
          height: AppSize.h(240),
          "https://plus.unsplash.com/premium_photo-1764179759141-b947f855a432?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxNzZ8fHxlbnwwfHx8fHw%3D",
          fit: BoxFit.fitHeight,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsetsGeometry.only(left: 15),
          child: AppText.caption(
            "\$9999",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsetsGeometry.only(left: 15, top: 5, right: 40),
          child: AppText.caption(
            "About the Product",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Image.network(
                "https://images.unsplash.com/photo-1764484636506-cf6398999671?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxNzh8fHxlbnwwfHx8fHw%3D",
                fit: BoxFit.fitWidth,
                width: 200,
                height: 100,
              ),
              Image.network(
                "https://images.unsplash.com/photo-1761839259488-2bdeeae794f5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDF8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxNzl8fHxlbnwwfHx8fHw%3D",
                fit: BoxFit.fitWidth,
                width: 200,
                height: 100,
              ),
              Image.network(
                "https://images.unsplash.com/photo-1766834123530-8a58354b43ac?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxODh8fHxlbnwwfHx8fHw%3D",
                fit: BoxFit.fitWidth,
                width: 200,
                height: 100,
              ),
              Image.network(
                "https://images.unsplash.com/photo-1761465064094-22407e36f512?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxOTJ8fHxlbnwwfHx8fHw%3D",
                fit: BoxFit.fill,
                width: 200,
                height: 100,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsetsGeometry.only(left: 15, top: 15, bottom: 15),
          alignment: Alignment.topLeft,
          child: AppText.body("See All Deals", color: Colors.cyan[800]),
        ),
      ],
    );
  }
}
