import 'package:flutter/material.dart';

class MerchantSearchResultCard extends StatelessWidget {
  void Function() onTap;
  String merchantName;
  String merchantImage;
  double? merchantDistance;

  MerchantSearchResultCard({
    super.key,
    required this.onTap,
    required this.merchantName,
    required this.merchantImage,
    this.merchantDistance,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.3,
              child: Image.network(
                merchantImage,
                fit: BoxFit.cover,
              ),
            ),
            // horizontalTitleGap: 5,
            Text(
              merchantName,
            ),
            Text(
                // "${merchantDistance!.toStringAsFixed(2)} km",
                "km"),
          ],
        ),
      ),
    );
  }
}
