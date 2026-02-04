import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/models/order.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:frontend/features/admin/model/sales.dart';

class AdminServices {
    void sellProduct({
        required BuildContext context,
        required String name,
        required String description,
        required double price,
        required double quantity,
        required List<File> images,
        required String category,
    }) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        try {
            final cloudinary = CloudinaryPublic(
                dotenv.env['CLOUDINARY_NAME']!,
                dotenv.env['UPLOAD_PRESET']!,
                cache: false,
            );
            List<String> imageUrls = [];
            for (int i = 0; i < images.length; i++) {
                CloudinaryResponse response = await cloudinary.uploadFile(
                    CloudinaryFile.fromFile(
                        images[i].path,
                        resourceType: CloudinaryResourceType.Image,
                        folder: name,
                    ),
                );
                imageUrls.add(response.secureUrl);
            }

            Product product = Product(
                name: name,
                description: description,
                price: price,
                quantity: quantity,
                images: imageUrls,
                category: category,
            );

            // add the product
            http.Response res = await http.post(
                Uri.parse('$baseUrl/admin/add-product'),
                headers: {
                    'Content-Type': 'application/json',
                    'x-auth-token': userProvider.user.token,
                },
                body: product.toJson(),
            );
            HttpErrorHandling(
                response: res,
                onSuccess: () {
                    showSnackbar(
                        'Product add Successfully',
                        title: "Success",
                        backgroundColor: Colors.green,
                        icon: CupertinoIcons.checkmark_alt,
                    );
                    Navigator.pop(context);
                },
            );
        } catch (e) {
            showSnackbar(e.toString());
        }
    }

    // get all the product
    Future<List<Product>> fetchAllProduct(BuildContext context) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        List<Product> productList = [];
        try {
            http.Response res = await http.get(
                Uri.parse('$baseUrl/admin/get-product'),
                headers: {
                    'Content-Type': 'application/json',
                    'x-auth-token': userProvider.user.token,
                },
            );

            HttpErrorHandling(
                response: res,
                onSuccess: () {
                    final List data = jsonDecode(res.body);
                    for (int i = 0; i < data.length; i++) {
                        productList.add(Product.fromJson(jsonEncode(data[i])));
                    }
                },
            );
        } catch (e) {
            showSnackbar(e.toString());
        }
        return productList;
    }

    // delete the product
    void deleteProduct({
        required BuildContext context,
        required Product product,
        required VoidCallback onSuccess,
    }) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        var id = product.id;
        try {
            http.Response res = await http.delete(
                Uri.parse('$baseUrl/admin/delete-product/$id'),
                headers: {
                    'Content-Type': 'application/json',
                    'x-auth-token': userProvider.user.token,
                },
            );
            HttpErrorHandling(
                response: res,
                onSuccess: () {
                    onSuccess();
                },
            );
        } catch (e) {
            print(e.toString());
            showSnackbar(e.toString());
        }
    }
    // changing order status
    void changeOrderStatus({
        required BuildContext context,
        required int status,
        required Order order,
        required VoidCallback onSuccess,
    }) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        try {
            http.Response res = await http.post(
                Uri.parse('$baseUrl/admin/change-order-status'),
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                    'x-auth-token': userProvider.user.token,
                },
                body: jsonEncode({
                    'id': order.id,
                    'status': status,
                }),
            );

            HttpErrorHandling(
                response: res,
                onSuccess: onSuccess,
            );
        } catch (e) {
            showSnackbar(e.toString());
        }
    }

    // fetching the product
    Future<List<Order>> fetchAllOrders(BuildContext context) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        List<Order> orderList = [];
        try {
            http.Response res =
                await http.get(Uri.parse('$baseUrl/admin/get-orders'), headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                        'x-auth-token': userProvider.user.token,
                    });

            HttpErrorHandling(
                response: res,

                onSuccess: () {
                    for (int i = 0; i < jsonDecode(res.body).length; i++) {
                        orderList.add(
                            Order.fromJson(
                                jsonEncode(
                                    jsonDecode(res.body)[i],
                                ),
                            ),
                        );
                    }
                },
            );
        } catch (e) {
            showSnackbar(e.toString());
        }
        return orderList;
    }
    // total earning graph
    Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        List<Sales> sales = [];
        int totalEarning = 0;
        try {
            http.Response res =
            await http.get(Uri.parse('$baseUrl/admin/analytics'), headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
            });

            HttpErrorHandling(
                response: res,

                onSuccess: () {
                    var response = jsonDecode(res.body);
                    totalEarning = response['totalEarnings'];
                    sales = [
                        Sales('Mobiles', response['mobileEarnings']),
                        Sales('Essentials', response['essentialEarnings']),
                        Sales('Books', response['booksEarnings']),
                        Sales('Appliances', response['applianceEarnings']),
                        Sales('Fashion', response['fashionEarnings']),
                    ];
                },
            );
        } catch (e) {
            showSnackbar(e.toString());
        }
        return {
            'sales': sales,
            'totalEarnings': totalEarning,
        };
    }
}


