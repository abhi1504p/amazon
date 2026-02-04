import 'package:frontend/constants/app_size.dart';
import 'package:frontend/core/widgets/loader.dart';
import 'package:frontend/features/admin/model/sales.dart';

import 'package:frontend/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/admin/widgets/admin_appbar.dart';
import 'package:frontend/features/admin/widgets/category_product_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AdminAppbar(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    '\$$totalSales',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.h(250),
                    child: CategoryProductsChart(data: earnings!),
                  ),
                ],
              ),
            ),
          );
  }
}
