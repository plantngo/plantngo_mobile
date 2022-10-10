import 'package:flutter/material.dart';

class MerchantShopPopularSection extends StatelessWidget {
  const MerchantShopPopularSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Popular",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              leading: SizedBox(
                height: 40,
                width: 40,
                child: Image.network(""),
              ),
              title: Text("Some food item"),
              subtitle: Text("Description of food item"),
              onTap: () {
                print("some food item clicked");
              },
            );
          },
        ),
      ],
    );
  }
}
