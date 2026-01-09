import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/screens/add_product_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  void addProductToUI() {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Post")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: GlobalVariables.lightbluecolor,
        elevation: 1,
        shape: CircleBorder(),
        onPressed: addProductToUI,
        tooltip: "Add a Product ",
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
