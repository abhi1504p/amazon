import 'package:flutter/material.dart';
import 'package:frontend/constants/app_size.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/core/widgets/app_text.dart';
import 'package:frontend/core/widgets/loader.dart';
import 'package:frontend/features/account/widgets/single_product_list.dart';
import 'package:frontend/features/admin/screens/add_product_screen.dart';
import 'package:frontend/features/admin/services/admin_services.dart';
import 'package:frontend/models/product.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    Future.microtask(fetchProducts); // ✅ SAFE
  }

  void fetchProducts() async {
    products = await adminServices.fetchAllProduct(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void addProductToUI() async {
    await Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(AddProductScreen.routeName);

    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: AppSize.h(140),
                      child: SingleProductList(image: productData.images[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: AppText.body(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteProduct(productData, index),
                          icon: Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: GlobalVariables.lightbluecolor,
              elevation: 1,
              shape: CircleBorder(),
              onPressed: addProductToUI,
              tooltip: "Add a Product ",
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
