import 'package:flutter/material.dart';

class MerchantShopDetailsScreen extends StatefulWidget {
  int merchantId;
  String merchantName;
  double merchantDistance;
  String merchantImage;

  MerchantShopDetailsScreen({
    super.key,
    required this.merchantId,
    required this.merchantName,
    required this.merchantDistance,
    required this.merchantImage,
  });

  @override
  State<MerchantShopDetailsScreen> createState() =>
      _MerchantShopDetailsScreenState();
}

class _MerchantShopDetailsScreenState extends State<MerchantShopDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // data retrieval by id
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.merchantName),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Profile"),
              Divider(
                thickness: 5,
                color: Theme.of(context).indicatorColor,
              ),
              Text("Menu")
            ],
          ),
        ),
      ),
    );
  }
}
