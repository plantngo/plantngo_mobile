import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenMerchant extends StatefulWidget {
  const HomeScreenMerchant({super.key});

  @override
  State<HomeScreenMerchant> createState() => _HomeScreenMerchantState();
}

class _HomeScreenMerchantState extends State<HomeScreenMerchant> {
  @override
  Widget build(BuildContext context) {
    var merchantProvider = Provider.of<MerchantProvider>(context, listen: true);
    return Scaffold(
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
