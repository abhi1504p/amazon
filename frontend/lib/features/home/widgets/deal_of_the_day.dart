import 'package:flutter/material.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:frontend/core/widgets/loader.dart';
import 'package:frontend/features/home/service/home_service.dart';
import 'package:frontend/features/product_details/screen/product_details_screen.dart';
import 'package:frontend/models/product.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;
  final HomeService homeServices = HomeService();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
        ? const SizedBox()
        : GestureDetector(
            onTap: navigateToDetailScreen,
            child: Column(
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
                  product!.images[0],
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
                    children: product!.images
                        .map(
                          (e) => Image.network(
                            e,
                            fit: BoxFit.fitWidth,
                            width: 100,
                            height: 100,
                          ),
                        )
                        .toList(),
                  ),
                ),

                Container(
                  padding: EdgeInsetsGeometry.only(
                    left: 15,
                    top: 15,
                    bottom: 15,
                  ),
                  alignment: Alignment.topLeft,
                  child: AppText.body("See All Deals", color: Colors.cyan[800]),
                ),
              ],
            ),
          );
  }
}
