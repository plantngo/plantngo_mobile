import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/customer/cart/cart_main_screen.dart';
import 'package:plantngo_frontend/screens/user_profile_section.dart';
import 'package:plantngo_frontend/screens/user_settings_section.dart';
import 'package:plantngo_frontend/services/auth_service.dart';

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            shape: const CircleBorder(),
            // Lead to checkout page
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CartMainScreen()),
              );
            },
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     boxShadow: [
        //       const BoxShadow(
        //         color: Colors.grey,
        //         offset: Offset(0, 2.0),
        //         blurRadius: 4.0,
        //       )
        //     ],
        //     gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [
        //         Colors.green.shade200,
        //         Colors.green.shade300,
        //         Colors.green,
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            UserProfileSection(),
            const SizedBox(height: 10),
            UserSettingSection(),
            const SizedBox(height: 20),
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
