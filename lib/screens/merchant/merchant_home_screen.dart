import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:provider/provider.dart';

class MerchantHomeScreen extends StatefulWidget {
  const MerchantHomeScreen({super.key});

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var merchantProvider = Provider.of<MerchantProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello, ${merchantProvider.merchant.username}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const Text(
              "Merchant Home Page",
            ),
            Text(merchantProvider.merchant.username.toString()),
            Text(merchantProvider.merchant.email.toString()),
            Text(merchantProvider.merchant.company.toString()),
          ],
        ),
      ),
    );
  }
}
