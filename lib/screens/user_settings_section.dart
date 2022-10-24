import 'package:flutter/material.dart';
import 'package:plantngo_frontend/services/auth_service.dart';

import 'user_setting_screen.dart';

class UserSettingSection extends StatelessWidget {
  const UserSettingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> iconsList = [
      Icons.credit_card,
      Icons.compare_arrows,
    ];
    List<String> titleList = [
      "Payment Methods",
      "Profile Settings",
    ];
    List<String> subtitleList = [
      "",
      "",
    ];
    List<String> routeList = ["", UserSettingScreen.routeName];
    return Column(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: iconsList.length,
          shrinkWrap: true,
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
                              color: Colors.black,
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
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            subtitleList[i],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        size: 20,
                        color: Colors.black,
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
