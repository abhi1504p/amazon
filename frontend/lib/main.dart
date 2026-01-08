import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/core/widgets/bottom_bar.dart';
import 'package:frontend/features/auth/services/auth_services.dart';

import 'package:frontend/provider/user_provider.dart';

import 'package:frontend/router.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'constants/global_variables.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/home/screens/home_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Amazon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: ColorScheme.fromSeed(
            seedColor: GlobalVariables.secondaryColor,
            brightness: Brightness.light,
          ).primary,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent, // important for M3
          iconTheme: const IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ?  const PersistentBottomNavBarDemo()
          : const AuthScreen(),
    );
  }
}
