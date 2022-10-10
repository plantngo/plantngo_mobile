import 'package:flutter/material.dart';

class MerchantShopMenuSection extends StatelessWidget {
  const MerchantShopMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Menu",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
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
