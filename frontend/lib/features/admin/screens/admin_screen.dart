import 'package:flutter/material.dart';
import 'package:frontend/features/admin/widgets/admin_appbar.dart';
import 'package:frontend/features/admin/widgets/admin_bottom_bar.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AdminAppbar(),
      ),
      body: AdminBottomBar(),
    );
  }
}
