import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/utils/functions.dart';
import 'package:provider/provider.dart';

class MerchantProfileSection extends StatelessWidget {
  const MerchantProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final String fullName =
        Provider.of<MerchantProvider>(context, listen: false)
            .merchant
            .username
            .toString();
    final String mobileNumber = "+65 9123 4567";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 50,
              child: CircleAvatar(
                backgroundColor: generateColor(fullName),
                child: Text(
                  getInitials(fullName, " "),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        Column(
          children: const [
            SizedBox(
              width: 10,
            )
          ],
        ),
        Column(
          children: [
            Row(children: [
              Text(fullName),
            ]),
            Row(children: [
              Text(mobileNumber),
            ]),
          ],
        ),
      ],
    );
  }
}
