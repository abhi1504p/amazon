import 'package:flutter/material.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AdminAppbar extends StatelessWidget {
  const AdminAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/amazon_in.png',
              height: AppSize.h(40),
              width: AppSize.w(150),
            ),
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 5),
            child: AppText.heading(user.type, fontSize: 23),
          ),
        ],
      ),
    );
  }
}
