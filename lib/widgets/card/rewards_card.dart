import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/rewards.dart';

class RewardsCard extends StatelessWidget {
  const RewardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    var rewardName = "Heading";
    var price = "<Price>";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              stops: [0.02, 0.02],
              colors: [Colors.greenAccent, Colors.white],
            ),
          ),
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
                      title: Text(rewardName,
                          style: const TextStyle(fontSize: 20)),
                      subtitle: Text("Price: $price",
                          style: TextStyle(
                              fontSize: 15, color: Colors.orange[900])),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, bottom: 4, top: 26),
                          child: IconButton(
                            icon: const Icon(Icons.add_shopping_cart, size: 30),
                            onPressed: () {},
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
      ),
    );
  }
}
