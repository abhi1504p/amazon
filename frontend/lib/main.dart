import 'package:flutter/material.dart';

import 'package:frontend/features/auth/screens/auth_screen.dart';
import 'package:frontend/router.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Amazon',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData.light(
    //     useMaterial3: true,
    //
    //     // scaffoldBackgroundColor: GlobalVariables.backgroundColor,
    //
    //     // appBarTheme: AppBarTheme(
    //     //   elevation: 0,
    //     //   backgroundColor: ColorScheme.fromSeed(
    //     //     seedColor: GlobalVariables.secondaryColor,
    //     //     brightness: Brightness.light,
    //     //   ).primary,
    //     //   foregroundColor: Colors.white,
    //     //   surfaceTintColor: Colors.transparent, // important for M3
    //     //   iconTheme: const IconThemeData(color: Colors.black),
    //     // ),
    //   ),
    //
    //   home: AuthScreen(),
    // );
    return GetMaterialApp(
      initialRoute: AppRoutes.auth,
      getPages: getPages,
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(
          body: Center(child: Text('This screen is not present')),
        ),
      ),
    );

  }
}
