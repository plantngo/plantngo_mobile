import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/utils/functions.dart';
import 'package:provider/provider.dart';

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    String fullName =
        Provider.of<CustomerProvider>(context).customer.username ?? "";
    String? mobileNumber =
        Provider.of<CustomerProvider>(context).customer.email ?? "";

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: generateColor(fullName),
                    child: Text(
                      getInitials(fullName, ""),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Row(children: [
              Text(
                fullName,
                style: Theme.of(context).textTheme.caption,
              ),
            ]),
            Row(children: [
              Text(
                mobileNumber,
                style: Theme.of(context).textTheme.caption,
              ),
            ]),
          ],
        )
      ],
    );
  }
}
