import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/loader.dart';
import 'package:frontend/features/account/service/account_service.dart';
import 'package:frontend/features/account/widgets/single_product_list.dart';
import 'package:frontend/features/order_details/screen/order_details.dart';
import 'package:frontend/models/order.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

// List list = [
//   'https://images.unsplash.com/photo-1767857393552-9e6a7a7e669a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw0fHx8ZW58MHx8fHx8',
//   'https://images.unsplash.com/photo-1767857393552-9e6a7a7e669a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw0fHx8ZW58MHx8fHx8',
//   'https://images.unsplash.com/photo-1767700358934-3466f476d948?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyMXx8fGVufDB8fHx8fA%3D%3D',
//   'https://images.unsplash.com/photo-1767857393552-9e6a7a7e669a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw0fHx8ZW58MHx8fHx8',
//   'https://images.unsplash.com/photo-1767857393552-9e6a7a7e669a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw0fHx8ZW58MHx8fHx8',
//   'https://images.unsplash.com/photo-1767700358934-3466f476d948?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyMXx8fGVufDB8fHx8fA%3D%3D',
// ];

class _OrderListState extends State<OrderList> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  void fetchOrder() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : ListView.builder(
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,arguments: orders![index]);
                },
                child: SingleProductList(
                  image: orders![index].products[0].images[0],
                ),
              ),
            ),
          );
  }
}
