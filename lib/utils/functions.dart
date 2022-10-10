import 'package:flutter/widgets.dart';
import 'dart:math' as math;

Color generateColor(String username) {
  return Color(
          (math.Random(username.codeUnitAt(0)).nextDouble() * 0xFFFFFF).toInt())
      .withOpacity(1.0);
}

String getInitials(String lastName, String firstName) {
  String result = "";
  result = lastName[0].toUpperCase();
  return result;
}
