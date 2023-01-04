import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/merchant/profile/merchant_settings_section.dart';
import 'package:plantngo_frontend/screens/merchant/profile/promotion/merchant_promotion_screen.dart';
import 'package:plantngo_frontend/screens/merchant/profile/voucher/merchant_voucher_screen.dart';
import 'package:plantngo_frontend/screens/user_profile_section.dart';
import 'package:plantngo_frontend/screens/user_settings_section.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';

class MerchantProfileScreen extends StatefulWidget {
  const MerchantProfileScreen({super.key});

  @override
  State<MerchantProfileScreen> createState() => _MerchantProfileScreenState();
}

class _MerchantProfileScreenState extends State<MerchantProfileScreen> {
  void logOut() {
    AuthService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ).copyWith(
            elevation: ButtonStyleButton.allOrNull(0.0),
          ),
          child: const Text('Log Out'),
          onPressed: () {
            logOut();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const UserProfileSection(),
            const SizedBox(height: 10),
            const UserSettingSection(),
            const Divider(),
            const MerchantSettingSection(),
          ],
        ),
      ),
    );
  }
}
