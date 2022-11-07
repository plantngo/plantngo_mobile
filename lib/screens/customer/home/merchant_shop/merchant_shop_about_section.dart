import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/widgets/tag/carbon_tag.dart';
import 'package:plantngo_frontend/widgets/tag/price_tag.dart';
import 'package:plantngo_frontend/widgets/tag/tag.dart';

class MerchantShopAboutSection extends StatelessWidget {
  MerchantSearch merchant;
  MerchantShopAboutSection({
    super.key,
    required this.merchant,
  });

  renderDistanceAndCuisineTag() {
    if (merchant.distanceFrom == null || merchant.distanceFrom == -1) {
      return [
        Tag(text: merchant.cuisineType),
      ];
    }

    return [
      Tag(
        text: "${merchant.distanceFrom!.toStringAsFixed(2)} km",
      ),
      Tag(text: merchant.cuisineType),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "About",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  subtitle: TextButton(
                    onPressed: (() {
                      MapsLauncher.launchQuery(
                        merchant.address,
                      );
                    }),
                    child: Text(
                      merchant.address,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.underline,
                            color: Colors.green,
                          ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Opening Hours",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    merchant.operatingHours,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                ExpansionTile(
                  title: Row(
                    children: [
                      Text(
                        "Average Carbon Emission",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: Wrap(
                        children: [
                          Text(
                            "${merchant.company}'s products emit on average",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            " ~${merchant.carbonRating!.toStringAsFixed(2)} gCO2 (grams of Carbon Dioxide)",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        merchant.description,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
                ListTile(
                  // horizontalTitleGap: 5,
                  title: Text(
                    "Store Tags",
                    style: Theme.of(context).textTheme.bodyMedium,
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
                            text:
                                "~${merchant.carbonRating!.toStringAsFixed(0)} gCO2e"),
                        PriceTag(symbolCount: merchant.priceRating),
                        ...renderDistanceAndCuisineTag(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
