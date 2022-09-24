import 'package:flutter/material.dart';
import 'package:plantngo_frontend/utils/functions.dart';

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final String fullName = "John Tan";
    final String mobileNumber = "+65 9123 4567";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 50,
              child: CircleAvatar(
                backgroundColor: generateColor(fullName),
                child: Text(
                  getInitials(fullName, ""),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: 10,
            )
          ],
        ),
        Column(
          children: [
            Row(children: [
              Text(fullName),
            ]),
            Row(children: [
              Text(mobileNumber),
            ]),
          ],
        )
      ],
    );
  }
}
