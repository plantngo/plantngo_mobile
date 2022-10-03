import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plantngo_frontend/widgets/card/rewards_card.dart';


class RewardShop extends StatefulWidget {
  const RewardShop({super.key});

  @override
  State<RewardShop> createState() => _RewardShopState();
}

class _RewardShopState extends State<RewardShop> {
  var greenPoints = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Rewards Shop",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Green Points: ${greenPoints}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Column(
                    children: [
                      RewardsCard(),
                      RewardsCard(),
                      RewardsCard(),
                      RewardsCard(),
                      RewardsCard(),
                      RewardsCard(),
                      RewardsCard(),
                      RewardsCard(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // Lead to checkout page
        onPressed: () {},
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
