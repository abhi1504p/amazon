
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/core/widgets/loader.dart';
import 'package:frontend/features/account/widgets/single_product_list.dart';
import 'package:frontend/features/admin/services/admin_services.dart';
import 'package:frontend/features/order_details/screen/order_details.dart';
import 'package:frontend/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
                itemCount: orders!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
                itemBuilder: (context, index) {
          final orderData = orders![index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                OrderDetailScreen.routeName,
                arguments: orderData,
              );
            },
            child: SizedBox(
              height: AppSize.h(140),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleProductList(
                  image: orderData.products[0].images[0],
                ),
              ),
            ),
          );
                },
              ),
        );
  }
}