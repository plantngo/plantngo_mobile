import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/widgets/tag/tag.dart';

class MerchantSearchResultCard extends StatelessWidget {
  void Function() onTap;
  MerchantSearch merchant;

  MerchantSearchResultCard({
    super.key,
    required this.onTap,
    required this.merchant,
  });

  renderDistanceTag() {
    if (merchant.distanceFrom != null) {
      return Tag(
        text: "${merchant.distanceFrom!.toStringAsFixed(2)} km",
      );
    }
  }

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
                merchant.logoUrl,
                fit: BoxFit.cover,
              ),
            ),
            // horizontalTitleGap: 5,
            Text(
              merchant.company,
            ),
            renderDistanceTag(),
          ],
        ),
      ),
    );
  }
}
