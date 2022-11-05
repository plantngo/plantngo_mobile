import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:plantngo_frontend/models/orderitem.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';
import 'package:plantngo_frontend/utils/user_secure_storage.dart';
import 'package:provider/provider.dart';
import '../utils/global_variables.dart';

class CustomerOrderService {
  static Future<List<Order>> getAllOrdersByCustomer({
    required BuildContext context,
  }) async {
    List<Order> orders = [];
    try {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();
      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/v1/order/customer/${customerProvider.customer.username}'),
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

  static Future<List<Order>> getAllOrdersByCustomerAndOrderStatus({
    required BuildContext context,
    required String orderStatus,
  }) async {
    List<Order> orders = [];
    try {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();
      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/v1/order/customer/${customerProvider.customer.username}/orderStatus/$orderStatus'),
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

  static Future<Order?> getOrderByCustomerAndMerchantAndOrderStatus({
    required BuildContext context,
    required String merchantName,
    required String orderStatus,
  }) async {
    Order? order;
    try {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();
      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/v1/order/customer/${customerProvider.customer.username}/merchant/$merchantName/orderStatus/$orderStatus'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      order = Order.fromJson(jsonDecode(res.body));
    } catch (e) {}
    return order;
  }

  static Future createCustomerOrder(
      {required BuildContext context,
      required Order order,
      required String merchantName}) async {
    try {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();

      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/order/${customerProvider.customer.username}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          {
            "isDineIn": order.isDineIn,
            "merchantName": merchantName,
            "orderItems": [
              {
                "productId": order.orderItems!.first.productId,
                "quantity": order.orderItems!.first.quantity
              }
            ],
            "orderStatus": order.orderStatus,
          },
        ),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      //
    }
  }

  static Future createCustomerOrderItem({
    required BuildContext context,
    required String merchantName,
    required int orderId,
    required OrderItem orderItem,
  }) async {
    try {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();

      http.Response res = await http.post(
        Uri.parse(
            '$uri/api/v1/order/${customerProvider.customer.username}/$orderId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "productId": orderItem.productId,
          "quantity": orderItem.quantity,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      //
    }
  }

  static Future updateCustomerOrder(
      {required BuildContext context,
      required Order order,
      required String merchantName}) async {
    try {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();

      http.Response res = await http.put(
        Uri.parse('$uri/api/v1/order/${order.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          {
            "isDineIn": order.isDineIn,
            "merchantName": merchantName,
            "updateOrderItemDTOs": order.orderItems,
            "orderStatus": order.orderStatus,
          },
        ),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      //
    }
  }

  // static Future<List<Order>> getFulfilledOrdersByMerchant({
  //   required BuildContext context,
  // }) async {
  //   List<Order> orders = [];
  //   try {
  //     final merchantProvider =
  //         Provider.of<MerchantProvider>(context, listen: false);
  //     String? token = await UserSecureStorage.getToken();
  //     http.Response res = await http.get(
  //       Uri.parse(
  //           '$uri/api/v1/order/merchant/${merchantProvider.merchant.username}/fulfilled'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token'
  //       },
  //     );

  //     jsonDecode(res.body).map((e) => orders.add(Order.fromJson(e))).toList();
  //   } catch (e) {
  //     //todo
  //   }
  //   return orders;
  // }

  // static Future<List<Order>> getCancelledOrdersByMerchant({
  //   required BuildContext context,
  // }) async {
  //   List<Order> orders = [];
  //   try {
  //     final merchantProvider =
  //         Provider.of<MerchantProvider>(context, listen: false);
  //     String? token = await UserSecureStorage.getToken();
  //     http.Response res = await http.get(
  //       Uri.parse(
  //           '$uri/api/v1/order/merchant/${merchantProvider.merchant.username}/cancelled'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token'
  //       },
  //     );

  //     jsonDecode(res.body).map((e) => orders.add(Order.fromJson(e))).toList();
  //   } catch (e) {
  //     //todo
  //   }
  //   return orders;
  // }

  // static Future updateOrderStatusToFulfilled(
  //     {required BuildContext context, required Order order}) async {
  //   try {
  //     String? token = await UserSecureStorage.getToken();
  //     http.Response res = await http.put(
  //         Uri.parse('$uri/api/v1/order/${order.id}'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'Authorization': 'Bearer $token'
  //         },
  //         body: jsonEncode(
  //             {"isDineIn": order.isDineIn, "orderStatus": "FULFILLED"}));
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         showSnackBar(context, "Marked as fulfilled!");
  //       },
  //     );
  //   } catch (e) {
  //     //todo
  //   }
  // }
}
