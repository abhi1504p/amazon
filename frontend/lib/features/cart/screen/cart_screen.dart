import 'package:flutter/material.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/features/cart/widgets/cart_product.dart';
import 'package:frontend/features/cart/widgets/cart_subtotal.dart';
import 'package:frontend/features/home/widgets/address_box.dart';
import 'package:frontend/features/home/widgets/home_app_bar.dart';
import 'package:frontend/features/search/screen/search_screen.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(int sum) {
    // Navigator.pushNamed(
    //   context,
    //   AddressScreen.routeName,
    //   arguments: sum.toString(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(
                type: ButtonType.filled,
                text: 'Proceed to Buy (${user.cart.length} items)',
                onPressed: () => navigateToAddress(sum),
                color: Colors.yellow[600],
              ),
            ),
            SizedBox(height: AppSize.h(15)),
            Container(color: Colors.black12.withOpacity(0.08), height: 1),
            SizedBox(height: AppSize.h(5)),
            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
