import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';
import 'package:provider/provider.dart';
import '../models/voucher.dart';
import '../utils/global_variables.dart';

import '../utils/user_secure_storage.dart';

class ShopService {
  static Future<List<Voucher>> fetchAllVouchers(BuildContext context) async {
    String? token = await UserSecureStorage.getToken();

    List<Voucher> vouchers = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/store'),
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

  static void purchaseVouchers(BuildContext context) async {
    String? token = await UserSecureStorage.getToken();
    Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
    String username = payload['sub'];

    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/store/$username/purchase-voucher'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (res.statusCode == 200) {
        List<Voucher> cart = customerProvider.customer.vouchersCart;
        for (Voucher v in cart) {
          customerProvider.customer.ownedVouchers.add(v);
        }
      }
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
}
