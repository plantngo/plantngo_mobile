import 'package:flutter/material.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/screens/customer/user_profile_section.dart';
import 'package:plantngo_frontend/screens/customer/user_settings_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  void logOut() {
    AuthService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const Text(
              "Profile Page",
            ),
            UserProfileSection(),
            SizedBox(height: 10),
            UserSettingSection(),
            SizedBox(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
          ],
        ),
      ),
    );
  }
}
