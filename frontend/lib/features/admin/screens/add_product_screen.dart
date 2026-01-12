import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_input_field.dart';
import 'package:frontend/core/widgets/app_text.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String category = 'Mobiles';
  List<File> images = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  void selectedImage() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: AppText.heading("Add Product", fontSize: 20),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images
                            .map(
                              (item) => Builder(
                                builder: (context) {
                                  return Image.file(item, fit: BoxFit.fill);
                                },
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: AppSize.h(200),
                          viewportFraction: 1,
                          autoPlay: false,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectedImage,
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            radius: Radius.circular(10),
                            dashPattern: [10, 7],
                            strokeCap: StrokeCap.round,
                          ),
                          child: Container(
                            height: AppSize.h(150),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.folder_open_outlined, size: 40),
                                SizedBox(height: 10),
                                AppText.body(
                                  "Selected Product Image",
                                  color: Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                AppInputField(
                  obscureTexts: false,
                  labeltext: "Product Name",
                  keyboardType: TextInputType.name,
                  controller: productNameController,
                ),
                SizedBox(height: 10),
                AppInputField(
                  obscureTexts: false,
                  labeltext: "Description",
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
                  maxlines: 6,
                ),
                SizedBox(height: 10),
                AppInputField(
                  obscureTexts: false,
                  labeltext: "Price",
                  keyboardType: TextInputType.number,
                  controller: priceController,
                ),
                SizedBox(height: 10),
                AppInputField(
                  obscureTexts: false,
                  labeltext: "Quantity",
                  keyboardType: TextInputType.number,
                  controller: quantityController,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: Colors.white,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    initialValue: category,
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: AppText.caption(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                AppButton(
                  type: ButtonType.filled,
                  text: "Sell",
                  color: GlobalVariables.secondaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
