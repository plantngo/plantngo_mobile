import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/promotion.dart';
import '../utils/global_variables.dart';

import '../utils/user_secure_storage.dart';

class PromotionService {
  static Future<List<Promotion>> fetchAllPromotions(
      BuildContext context) async {
    String? token = await UserSecureStorage.getToken();

    List<Promotion> promotions = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/promotion'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (res.statusCode == 200) {
        for (var i = 0; i < res.body.length; i++) {
          promotions.add(Promotion.fromJSON(jsonDecode(res.body)[i]));
        }
      }
    } catch (e) {
      //to do catch exception
    }
    return promotions;
  }
}
