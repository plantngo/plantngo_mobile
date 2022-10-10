import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';

class MerchantShopAboutSection extends StatelessWidget {
  MerchantSearch merchant;
  MerchantShopAboutSection({
    super.key,
    required this.merchant,
  });

  @override
  Widget build(BuildContext context) {
    String merchantOpeningHours = "10:00AM - 08:00PM";

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
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
                ExpansionTile(
                  title: Text(
                    "Opening Hours",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    merchantOpeningHours,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        "",
                        style: Theme.of(context).textTheme.bodySmall,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
