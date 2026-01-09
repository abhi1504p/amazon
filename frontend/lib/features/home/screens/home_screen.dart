import 'package:flutter/material.dart';
import 'package:frontend/features/home/widgets/address_box.dart';
import 'package:frontend/features/home/widgets/carousal_image.dart';
import 'package:frontend/features/home/widgets/deal_of_the_day.dart';
import 'package:frontend/features/home/widgets/home_app_bar.dart';
import 'package:frontend/features/home/widgets/top_categories.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            SizedBox(height: 3),
            TopCategories(),
            SizedBox(height: 8),
            CarousalImage(),
            SizedBox(height: 2),
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
