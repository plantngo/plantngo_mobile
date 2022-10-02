import 'package:flutter/material.dart';
import 'package:plantngo_frontend/services/auth_service.dart';

class MerchantAccountScreen extends StatefulWidget {
  const MerchantAccountScreen({super.key});

  @override
  State<MerchantAccountScreen> createState() => _MerchantAccountScreenState();
}

class _MerchantAccountScreenState extends State<MerchantAccountScreen> {
  final AuthService authService = AuthService();

  void logOut() {
    authService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
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
