import 'package:flutter/material.dart';
import 'package:plantngo_frontend/widgets/card/rewards_card.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/models/rewards.dart';
import 'package:provider/provider.dart';

class RewardShop extends StatefulWidget {
  const RewardShop({super.key});

  @override
  State<RewardShop> createState() => _RewardShopState();
}

class _RewardShopState extends State<RewardShop> {
  var cartItems = [];

  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    var greenPoints = (customerProvider.customer.greenPoints == null)
        ? 0
        : customerProvider.customer.greenPoints;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Green Points: $greenPoints",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(225, 33, 150, 246),
          shape: const CircleBorder(),
          // Lead to checkout page
          onPressed: () {},
          child: const Icon(Icons.shopping_cart, color: Colors.black),
        ),
      ),
    );
  }
}
