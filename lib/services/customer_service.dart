import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;

import '../models/voucher.dart';
import '../utils/global_variables.dart';
import '../utils/user_secure_storage.dart';

class CustomerService {
  static void addVoucherToCart(BuildContext context, Voucher voucher) async {
    String? token = await UserSecureStorage.getToken();
    Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
    String username = payload['sub'];

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/$username/my-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "voucherId": voucher.id,
          "merchantId": "smth"
        }),
      );
      if (res.statusCode == 200) {}
    } catch (e) {
      //to do catch exception
    }
  }
}
