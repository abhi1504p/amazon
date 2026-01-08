import 'package:flutter/material.dart';

import 'package:frontend/core/widgets/app_button.dart';

class AccountButtons extends StatelessWidget {
  const AccountButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: AppButton(
                borderRadius: 30,
                padding: EdgeInsets.all(15),
                width: 180,
                background: Colors.grey.shade100,
                type: ButtonType.outlined,
                color: Colors.grey.shade400,
                textColor: Colors.black,
                onPressed: () {},
                text: "Your Orders",
              ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: AppButton(
                borderRadius: 30,
                padding: EdgeInsets.all(15),
                width: 180,
                color: Colors.grey.shade400,
                textColor: Colors.black,
                type: ButtonType.outlined,
                background: Colors.grey.shade100,
                onPressed: () {},
                text: "Turn Sellers",
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: AppButton(
                borderRadius: 30,
                padding: EdgeInsets.all(15),
                width: 180,
                color: Colors.grey.shade400,
                textColor: Colors.black,
                type: ButtonType.outlined,
                background: Colors.grey.shade100,
                onPressed: () {},
                text: "Log Out",
              ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: AppButton(
                borderRadius: 30,
                padding: EdgeInsets.all(15),
                width: 180,
                type: ButtonType.outlined,
                color: Colors.grey.shade400,
                textColor: Colors.black,
                background: Colors.grey.shade100,
                onPressed: () {},
                text: "Your Wish List",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
