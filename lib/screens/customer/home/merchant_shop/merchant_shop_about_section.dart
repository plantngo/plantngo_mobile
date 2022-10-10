import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MerchantShopAboutSection extends StatelessWidget {
  String merchantAddress;
  MerchantShopAboutSection({
    super.key,
    required this.merchantAddress,
  });

  @override
  Widget build(BuildContext context) {
    String merchantDescription = "Some Description about the company here ...";
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
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  subtitle: TextButton(
                    onPressed: (() {
                      MapsLauncher.launchQuery(
                        merchantAddress,
                      );
                    }),
                    child: Text(
                      merchantAddress,
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
                        "$merchantDescription",
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
                        "$merchantDescription",
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
