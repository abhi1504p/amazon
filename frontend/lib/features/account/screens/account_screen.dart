import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:frontend/features/account/widgets/account_buttons.dart';
import 'package:frontend/features/account/widgets/account_app_bar.dart';
import 'package:frontend/features/account/widgets/order_list.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AccountAppBars(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          AccountButtons(),
          SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.heading("Your Orders"),
                AppButton(
                  type: ButtonType.text,
                  text: "See all",
                  color: GlobalVariables.selectedNavBarColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 1),
          SizedBox(height: 200, width: double.infinity, child: OrderList()),
        ],
      ),
    );
  }
}
