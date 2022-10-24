import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/utils/functions.dart';
import 'package:provider/provider.dart';

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    String username =
        Provider.of<CustomerProvider>(context).customer.username == ''
            ? Provider.of<MerchantProvider>(context).merchant.username!
            : Provider.of<CustomerProvider>(context).customer.username!;
    String email = Provider.of<CustomerProvider>(context).customer.email == ''
        ? Provider.of<MerchantProvider>(context).merchant.email!
        : Provider.of<CustomerProvider>(context).customer.email!;
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
                    backgroundColor: generateColor(username),
                    child: Text(
                      getInitials(username, ""),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Row(children: [
              Text(
                username,
                style: Theme.of(context).textTheme.caption,
              ),
            ]),
            Row(children: [
              Text(
                email,
                style: Theme.of(context).textTheme.caption,
              ),
            ]),
          ],
        )
      ],
    );
  }
}
