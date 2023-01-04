import 'package:flutter/material.dart';

class MerchantShopReservationSection extends StatelessWidget {
  const MerchantShopReservationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Reservation Type & Collection Date",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
      ],
    );
  }
}
