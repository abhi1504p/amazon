import 'package:flutter/material.dart';
import 'package:frontend/features/home/widgets/home_app_bar.dart';
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
        preferredSize: Size.fromHeight(70),
        child: HomeAppBar(),
      ),
      body: Column(children: [

      ],),
    );
  }
}
