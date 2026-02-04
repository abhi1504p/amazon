import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/core/widgets/app_input_field.dart';
import 'package:frontend/features/address/service/address_service.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:pay/pay.dart';

import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
    static const String routeName = '/address';
    final String totalAmount;
    const AddressScreen({super.key, required this.totalAmount});

    @override
    State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
    final TextEditingController flatBuildingController = TextEditingController();
    final TextEditingController areaController = TextEditingController();
    final TextEditingController pincodeController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final _addressFormKey = GlobalKey<FormState>();


late     PaymentConfiguration? applePayConfig;
late PaymentConfiguration? googlePayConfig;
    bool isPaymentConfigLoaded = false;

    String addressToBeUsed = "";
    List<PaymentItem> paymentItems = [];
    final AddressServices addressServices = AddressServices();

    @override
    void initState() {
        super.initState();
        paymentItems.add(
            PaymentItem(
                amount: widget.totalAmount,
                label: 'Total Amount',
                status: PaymentItemStatus.final_price,
            ),
        );
        loadPaymentConfig();
    }

    @override
    void dispose() {
        super.dispose();
        flatBuildingController.dispose();
        areaController.dispose();
        pincodeController.dispose();
        cityController.dispose();
    }

    void onApplePayResult(res) {
        if (Provider.of<UserProvider>(
            context,
            listen: false,
        ).user.address.isEmpty) {
            addressServices.saveUserAddress(
                context: context,
                address: addressToBeUsed,
            );
        }
        addressServices.placeOrder(
            context: context,
            address: addressToBeUsed,
            totalSum: double.parse(widget.totalAmount),
        );
    }

    void onGooglePayResult(res) {
        if (Provider.of<UserProvider>(
            context,
            listen: false,
        ).user.address.isEmpty) {
            addressServices.saveUserAddress(
                context: context,
                address: addressToBeUsed,
            );
        }
        addressServices.placeOrder(
            context: context,
            address: addressToBeUsed,
            totalSum: double.parse(widget.totalAmount),
        );
    }

    void payPressed(String addressFromProvider) {
        addressToBeUsed = "";

        bool isForm =
            flatBuildingController.text.isNotEmpty ||
                areaController.text.isNotEmpty ||
                pincodeController.text.isNotEmpty ||
                cityController.text.isNotEmpty;

        if (isForm) {
            if (_addressFormKey.currentState!.validate()) {
                addressToBeUsed =
                '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
            } else {
                throw Exception('Please enter all the values!');
            }
        } else if (addressFromProvider.isNotEmpty) {
            addressToBeUsed = addressFromProvider;
        } else {
            showSnackbar('ERROR');
        }
    }
    Future<void> loadPaymentConfig() async {
      final aConfig = await PaymentConfiguration.fromAsset('applepay.json');
      final gConfig = await PaymentConfiguration.fromAsset('googlepay.json');
      setState(() {
        applePayConfig = aConfig;
        googlePayConfig = gConfig;
                isPaymentConfigLoaded = true;
            });
    }

    @override
    Widget build(BuildContext context) {
      if (!isPaymentConfigLoaded) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
        var address = context.watch<UserProvider>().user.address;
        return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                    flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            gradient: GlobalVariables.appBarGradient,
                        ),
                    ),
                ),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        children: [
                            if (address.isNotEmpty)
                            Column(
                                children: [
                                    Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black12),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                address,
                                                style: const TextStyle(fontSize: 18),
                                            ),
                                        ),
                                    ),
                                    const SizedBox(height: 20),
                                    const Text('OR', style: TextStyle(fontSize: 18)),
                                    const SizedBox(height: 20),
                                ],
                            ),
                            Form(
                                key: _addressFormKey,
                                child: Column(
                                    children: [
                                        AppInputField(
                                            obscureTexts: false,
                                            controller: flatBuildingController,
                                            labeltext: 'Flat, House no, Building',
                                        ),
                                        const SizedBox(height: 10),
                                        AppInputField(
                                            obscureTexts: false,
                                            controller: areaController,
                                            labeltext: 'Area, Street',
                                        ),
                                        const SizedBox(height: 10),
                                        AppInputField(
                                            obscureTexts: false,
                                            controller: pincodeController,
                                            labeltext: 'Pincode',
                                        ),
                                        const SizedBox(height: 10),
                                        AppInputField(
                                            obscureTexts: false,
                                            controller: cityController,
                                            labeltext: 'Town/City',
                                        ),
                                        const SizedBox(height: 10),
                                    ],
                                ),
                            ),
                            ApplePayButton(
                                width: double.infinity,
                                style: ApplePayButtonStyle.whiteOutline,
                                type: ApplePayButtonType.buy,

                                onPaymentResult: onApplePayResult,
                                paymentItems: paymentItems,
                                margin: const EdgeInsets.only(top: 15),
                                height: 50,
                                onPressed: () => payPressed(address),
                                paymentConfiguration: applePayConfig!,
                            ),

                            const SizedBox(height: 10),
                            GooglePayButton(
                                onPressed: () => payPressed(address),

                                paymentConfiguration: googlePayConfig!,
                                onPaymentResult: onGooglePayResult,
                                paymentItems: paymentItems,
                                height: 50,

                                type: GooglePayButtonType.buy,
                                margin: const EdgeInsets.only(top: 15),
                                loadingIndicator: const Center(
                                    child: CircularProgressIndicator(),
                                ),
                            ),
                        ]
                    ),
                ),
            )
        );
    }
}
