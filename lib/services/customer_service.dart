import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/voucher.dart';
import '../providers/customer_provider.dart';
import '../utils/error_handling.dart';
import '../utils/global_variables.dart';
import '../utils/user_secure_storage.dart';

class CustomerService {
  static void addVoucherToCart(BuildContext context, Voucher voucher) async {
    String? token = await UserSecureStorage.getToken();
    Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
    String username = payload['sub'];

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/store/$username/my-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
            {"voucherId": voucher.id, "merchantId": voucher.merchantId}),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // showSnackBar(context, res.body);
          });
    } catch (e) {
      //to do catch exception
    }
  }

  static void removeVoucherFromCart(
      BuildContext context, Voucher voucher) async {
    String? token = await UserSecureStorage.getToken();
    Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
    String username = payload['sub'];

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/v1/store/$username/my-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
            {"voucherId": voucher.id, "merchantId": voucher.merchantId}),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // showSnackBar(context, res.body);
          });
    } catch (e) {
      //to do catch exception
    }
  }

  static Future<List<Voucher>> fetchAllVouchersInCart(
      BuildContext context) async {
    String? token = await UserSecureStorage.getToken();
    Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
    String username = payload['sub'];
    List<Voucher> vouchers = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/$username/my-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (res.statusCode == 200) {
        for (var i = 0; i < res.body.length; i++) {
          vouchers.add(Voucher.fromJSON(jsonDecode(res.body)[i]));
        }
      }
    } catch (e) {
      //to do catch exception
    }
    return vouchers;
  }

}
