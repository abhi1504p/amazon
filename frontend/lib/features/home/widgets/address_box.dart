import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, size: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.only(left: 5),
              child: AppText.body(
                "Delivery to ${user.name} -- ${user.address}",
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 5, top: 2),
            child: Icon(Icons.arrow_drop_down_outlined, size: 20),
          ),
        ],
      ),
    );
  }
}
