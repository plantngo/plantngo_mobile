import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RewardsCard extends StatelessWidget {
  const RewardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    var heading = "Heading";
    var subheading = "Promotion Description";
    var supportingText = "supporting Text";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2.0,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: ListTile(
                    // insert company logo here
                    leading: FlutterLogo(size: 50.0),
                    title: Text(heading),
                    subtitle: Text(subheading),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 4),
                        child: IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () {/* ... */},
                          style: IconButton.styleFrom(
                            foregroundColor: colors.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
