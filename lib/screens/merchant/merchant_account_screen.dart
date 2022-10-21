import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/merchant/merchant_profile_section.dart';
import 'package:plantngo_frontend/screens/merchant/merchant_promotion_screen.dart';
import 'package:plantngo_frontend/screens/merchant/merchant_voucher_screen.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';

class MerchantAccountScreen extends StatefulWidget {
  const MerchantAccountScreen({super.key});

  @override
  State<MerchantAccountScreen> createState() => _MerchantAccountScreenState();
}

class _MerchantAccountScreenState extends State<MerchantAccountScreen> {
  void logOut() {
    AuthService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
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
            const SizedBox(height: 10),
            const MerchantProfileSection(),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pushNamed(
                        context, MerchantPromotionScreen.routeName);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0.0, 20, 0.0),
                        child: Icon(
                          Icons.monetization_on_rounded,
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Promotions",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Create and track promotions",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      const Spacer(flex: 2),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      const Spacer(),
                    ]),
                  )),
            ),
            SizedBox(
              height: 80,
              child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pushNamed(
                        context, MerchantVoucherScreen.routeName);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0.0, 20, 0.0),
                        child: Icon(
                          Icons.percent_rounded,
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Vouchers",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Create and track store vouchers",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      const Spacer(flex: 2),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      const Spacer(),
                    ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
