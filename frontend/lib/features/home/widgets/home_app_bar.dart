import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_input_field.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
      ),
      title: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              height: 42,
              child: Material(
                borderRadius: BorderRadius.circular(7),
                elevation: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 23,
                        ),
                      ),
                    ),
                    filled: true,
                    hintText: "Search Amazon.in",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(bottom: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide(color: Colors.black38, width: 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.mic),
        ],
      ),
    );
  }
}
