import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/merchant/menu/merchant_setup_menu_screen.dart';

class PlaceholderItem extends StatelessWidget {
  String text = "";
  double height = 95;
  double widthPercent = 0.9;
  void Function() onTap;

  PlaceholderItem(
      {super.key,
      required this.text,
      required this.height,
      required this.onTap,
      required this.widthPercent});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: FractionallySizedBox(
          widthFactor: widthPercent,
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
