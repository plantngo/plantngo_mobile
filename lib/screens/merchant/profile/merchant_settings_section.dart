import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/merchant/menu/merchant_setup_menu_screen.dart';
import 'package:plantngo_frontend/screens/merchant/profile/promotion/merchant_promotion_screen.dart';
import 'package:plantngo_frontend/screens/merchant/profile/voucher/merchant_voucher_screen.dart';
import 'package:plantngo_frontend/services/auth_service.dart';

class MerchantSettingSection extends StatelessWidget {
  const MerchantSettingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> iconsList = [
      Icons.menu_book_rounded,
      Icons.monetization_on_rounded,
      Icons.percent_rounded,
    ];
    List<String> titleList = [
      "Manage Menu",
      "Manage Promotions",
      "Manage Vouchers",
    ];
    List<String> subtitleList = [
      "Create and manage your business's menu items",
      "Create and manage your business's promotions",
      "Create and manage your business's vouchers",
    ];
    List<String> routeList = [
      MerchantSetupMenuScreen.routeName,
      MerchantPromotionScreen.routeName,
      MerchantVoucherScreen.routeName
    ];
    return Column(
      children: [
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: iconsList.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (_, i) {
            return ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              color: Theme.of(context).colorScheme.secondary,
                              size: 30,
                              iconsList[i],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleList[i],
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            subtitleList[i],
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        size: 20,
                        color: Colors.grey,
                        Icons.arrow_forward_ios_rounded,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                AuthService.getUserData(context);
                Navigator.pushNamed(context, routeList[i]);
              }, // Handle your onTap here.
            );
          },
        )
      ],
    );
  }
}
