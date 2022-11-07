import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/widgets/tag/carbon_tag.dart';
import 'package:plantngo_frontend/widgets/tag/price_tag.dart';
import 'package:plantngo_frontend/widgets/tag/tag.dart';

class MerchantSearchSuggestionTile extends StatelessWidget {
  void Function() onTap;
  MerchantSearch merchant;

  MerchantSearchSuggestionTile({
    super.key,
    required this.onTap,
    required this.merchant,
  });

  renderDistanceAndCuisineTag() {
    if (merchant.distanceFrom == null || merchant.distanceFrom == -1) {
      return [
        Tag(text: merchant.cuisineType),
      ];
    }

    [
      Tag(
        text: "${merchant.distanceFrom!.toStringAsFixed(2)} km",
      ),
      Tag(text: merchant.cuisineType),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Image.network(merchant.logoUrl),
      ),
      // horizontalTitleGap: 5,
      title: Text(
        merchant.company,
      ),
      subtitle: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: double.maxFinite,
        ),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            CarbonTag(
                text: "~${merchant.carbonRating!.toStringAsFixed(0)} gCO2e"),
            PriceTag(symbolCount: merchant.priceRating),
            ...renderDistanceAndCuisineTag(),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
