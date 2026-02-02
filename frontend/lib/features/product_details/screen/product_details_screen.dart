import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:frontend/core/widgets/carousal_image.dart';
import 'package:frontend/core/widgets/star.dart';
import 'package:frontend/features/product_details/services/product_details_services.dart';
import 'package:frontend/features/search/screen/search_screen.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  double avgRating=0;
  double myRating=0;


  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalRating=0;
    for(int i=0;i<widget.product.rating!.length;i++){
      totalRating+=widget.product.rating![i].rating;
      if(widget.product.rating![i].userId==Provider.of<UserProvider>(context,listen: false).user.id){
        myRating=widget.product.rating![i].rating;
      }
    }
    if(totalRating!=0){
      avgRating=totalRating/widget.product.rating!.length;
    }

  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  height: AppSize.h(42),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        hintText: "Search Amazon.in",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(bottom: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.mic),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [AppText.body(widget.product.id!), Star(rating: avgRating)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: AppText.title(
                widget.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 2, right: 20),
              child: CarousalImage(
                images: widget.product.images,
                height: AppSize.h(280),
                boxFit: BoxFit.contain,
              ),
            ),
            Container(color: Colors.black12, height: 6),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Deal Price: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: "\$${widget.product.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText.caption(widget.product.description),
            ),
            Container(color: Colors.black12, height: 6),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AppButton(
                type: ButtonType.filled,
                text: "Buy Now",
                onPressed: () {},
                borderRadius: 2,
                color: GlobalVariables.secondaryColor,
                textColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(
                type: ButtonType.filled,
                text: "Add to Cart",
                onPressed: addToCart,
                borderRadius: 2,
                color: Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            SizedBox(height: 10),
            Container(color: Colors.black12, height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AppText.body(
                "Rate the Product",
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              maxRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsetsGeometry.symmetric(horizontal: 2),
              itemBuilder: (context, _) =>
                  Icon(Icons.star, color: GlobalVariables.secondaryColor),
              onRatingUpdate: (rating) {
                productDetailsServices.rateProduct(
                  context: context,
                  product: widget.product,
                  rating: rating,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
