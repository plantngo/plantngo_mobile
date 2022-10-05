import 'package:flutter/material.dart';

class MerchantSearchSuggestionTile extends StatelessWidget {
  void Function() onTap;
  String merchantName;
  double merchantDistance;
  String merchantImage;

  MerchantSearchSuggestionTile({
    super.key,
    required this.onTap,
    required this.merchantName,
    required this.merchantDistance,
    required this.merchantImage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Image.network(merchantImage),
      ),
      // horizontalTitleGap: 5,
      title: Text(
        merchantName,
      ),
      subtitle: Text(
        "${merchantDistance.toStringAsFixed(2)} km",
      ),
      onTap: onTap,
    );
  }
}
