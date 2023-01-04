import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/merchant/menu/merchant_setup_menu_screen.dart';

class PlaceholderItem extends StatelessWidget {
  String text = "";
  PlaceholderItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(MerchantSetupMenuScreen.routeName);
      },
      child: SizedBox(
        height: 80,
        child: FractionallySizedBox(
          widthFactor: 0.95,
          child: DottedBorder(
            dashPattern: [
              6,
            ],
            color: Colors.grey.shade400,
            strokeWidth: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
