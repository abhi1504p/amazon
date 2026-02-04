import 'package:flutter/material.dart';
import 'package:frontend/features/address/screen/address_screen.dart';
import 'package:frontend/features/admin/screens/add_product_screen.dart';
import 'package:frontend/features/auth/screens/auth_screen.dart';
import 'package:frontend/features/home/screens/category_deals_screen.dart';
import 'package:frontend/features/home/screens/home_screen.dart';
import 'package:frontend/features/order_details/screen/order_details.dart';
import 'package:frontend/features/product_details/screen/product_details_screen.dart';
import 'package:frontend/features/search/screen/search_screen.dart';
import 'package:frontend/models/product.dart';

import 'models/order.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
        case AuthScreen.routeName:
            return MaterialPageRoute(
                settings: routeSettings,
                builder: (_) => const AuthScreen(),
            );
        case HomeScreen.routeName:
            return MaterialPageRoute(
                settings: routeSettings,
                builder: (_) => const HomeScreen(),
            );
        case AddProductScreen.routeName:
            return MaterialPageRoute(
                settings: routeSettings,
                builder: (_) => const AddProductScreen(),
            );
        case AddressScreen.routeName:
            var totalAmount = routeSettings.arguments as String;
            return MaterialPageRoute(
                settings: routeSettings,
                builder: (_) => AddressScreen(totalAmount: totalAmount),
            );
        case SearchScreen.routeName:
            var searchQuery = routeSettings.arguments as String;
            return MaterialPageRoute(
                settings: routeSettings,
                builder: (_) => SearchScreen(searchQuery: searchQuery),
            );case OrderDetailScreen.routeName:
            var order = routeSettings.arguments as Order;
            return MaterialPageRoute(
                settings: routeSettings,
                builder: (_) => OrderDetailScreen(order: order),
            );
        case CategoryDealsScreen.routeName:
            var category = routeSettings.arguments as String;
            return MaterialPageRoute(
                settings: routeSettings,
                builder: (_) => CategoryDealsScreen(category: category),
            );
        case ProductDetailsScreen.routeName:
            var product = routeSettings.arguments as Product;
            return MaterialPageRoute(
                settings: routeSettings,
                builder: (_) => ProductDetailsScreen(product: product),
            );

        default:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) =>
            const Scaffold(body: Center(child: Text('Screen does not exist!'))),
        );
    }
}
