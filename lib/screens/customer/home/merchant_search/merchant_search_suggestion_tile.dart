import 'package:flutter/material.dart';
import 'package:plantngo_frontend/widgets/tag/price_tag.dart';
import 'package:plantngo_frontend/widgets/tag/tag.dart';

class MerchantSearchSuggestionTile extends StatelessWidget {
  void Function() onTap;
  String merchantName;
  String merchantImage;
  double? merchantDistance;

  MerchantSearchSuggestionTile({
    super.key,
    required this.onTap,
    required this.merchantName,
    required this.merchantImage,
    this.merchantDistance,
  });

  renderDistanceTag() {
    if (merchantDistance != null) {
      return Tag(
        text: "${merchantDistance!.toStringAsFixed(2)} km",
      );
    }
  }

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
      subtitle: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.maxFinite,
        ),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            PriceTag(symbolCount: 2),
            renderDistanceTag(),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
