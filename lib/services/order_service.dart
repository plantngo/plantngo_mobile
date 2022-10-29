import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';
import 'package:plantngo_frontend/utils/user_secure_storage.dart';
import 'package:provider/provider.dart';
import '../utils/global_variables.dart';

class OrderService {
  static Future<List<Order>> getPendingOrdersByMerchant({
    required BuildContext context,
  }) async {
    List<Order> orders = [];
    try {
      final merchantProvider =
          Provider.of<MerchantProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();
      http.Response res = await await http.get(
        Uri.parse(
            '$uri/api/v1/order/merchant/${merchantProvider.merchant.username}/pending'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      jsonDecode(res.body).map((e) => orders.add(Order.fromJson(e))).toList();
    } catch (e) {
      //todo
    }
    return orders;
  }

  static Future<List<Order>> getFulfilledOrdersByMerchant({
    required BuildContext context,
  }) async {
    List<Order> orders = [];
    try {
      final merchantProvider =
          Provider.of<MerchantProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();
      http.Response res = await await http.get(
        Uri.parse(
            '$uri/api/v1/order/merchant/${merchantProvider.merchant.username}/fulfilled'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      jsonDecode(res.body).map((e) => orders.add(Order.fromJson(e))).toList();
    } catch (e) {
      //todo
    }
    return orders;
  }

  static Future<List<Order>> getCancelledOrdersByMerchant({
    required BuildContext context,
  }) async {
    List<Order> orders = [];
    try {
      final merchantProvider =
          Provider.of<MerchantProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();
      http.Response res = await await http.get(
        Uri.parse(
            '$uri/api/v1/order/merchant/${merchantProvider.merchant.username}/cancelled'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      jsonDecode(res.body).map((e) => orders.add(Order.fromJson(e))).toList();
    } catch (e) {
      //todo
    }
    return orders;
  }

  static Future updateOrderStatusToFulFilled(
      {required BuildContext context, required Order order}) async {
    try {
      String? token = await UserSecureStorage.getToken();
      http.Response res = await await http.put(
          Uri.parse('$uri/api/v1/order/${order.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(
              {"isDineIn": order.isDineIn, "orderStatus": "FULFILLED"}));
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            res.body,
          );
        },
      );
    } catch (e) {
      //todo
    }
  }
}
