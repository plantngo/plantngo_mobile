import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/profile/user_profile_section.dart';
import 'package:plantngo_frontend/screens/profile/user_settings_section.dart';
import 'package:plantngo_frontend/utils/functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            UserProfileSection(),
            SizedBox(height: 10),
            UserSettingSection(),
          ],
        ),
      ),
    );
  }
}
