import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AccountAppBars extends StatelessWidget {
  const AccountAppBars({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: Get.height * .035),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/amazon_in.png',
                      height: 40,
                      width: 150,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        AppText.body("Hello,", fontSize: 22),
                        AppText.heading(
                          user.type,
                          fontSize: 23,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.search),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
