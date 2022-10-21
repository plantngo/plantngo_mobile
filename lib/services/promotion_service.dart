import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';
import 'package:provider/provider.dart';
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
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          // print(Promotion.fromJSON(jsonDecode(res.body)[i]));
          promotions.add(Promotion.fromJSON(jsonDecode(res.body)[i]));
        }
        // print(promotions);
      }
    } catch (e) {
      print(e);
      //to do catch exception
    }
    return promotions;
  }

  static Future<List<Promotion>> fetchAllPromotionsByMerchant(
      BuildContext context) async {
    String? token = await UserSecureStorage.getToken();

    MerchantProvider merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    List<Promotion> promotions = [];

    try {
      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/v1/promotion/${merchantProvider.merchant.username}'),
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

  static Future createPromotion(
      {required BuildContext context,
      required String bannerUrl,
      required String description,
      required String startDate,
      required String endDate}) async {
    String? token = await UserSecureStorage.getToken();

    MerchantProvider merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse(
              '$uri/api/v1/promotion/${merchantProvider.merchant.username}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            "bannerUrl": bannerUrl,
            "description": description,
            "endDate": endDate,
            "startDate": startDate
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Promotion Created",
          );
        },
      );
    } catch (e) {
      //todo
    }
  }

  static Future deletePromotion(
      {required BuildContext context, required int promotionId}) async {
    String? token = await UserSecureStorage.getToken();
    try {
      http.Response res = await http.delete(
          Uri.parse('$uri/api/v1/promotion/$promotionId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Promotion deleted",
          );
        },
      );
    } catch (e) {
      //todo
      print(e);
    }
  }

  static Future editPromotion(
      {required BuildContext context,
      required int promotionId,
      required String bannerUrl,
      required String description,
      required String startDate,
      required String endDate}) async {
    String? token = await UserSecureStorage.getToken();

    MerchantProvider merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    try {
      http.Response res =
          await http.put(Uri.parse('$uri/api/v1/promotion/$promotionId'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              },
              body: json.encode({
                "bannerUrl": bannerUrl,
                "description": description,
                "endDate": endDate,
                "startDate": startDate
              }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Promotion Updated",
          );
        },
      );
    } catch (e) {
      //todo
      print(e);
    }
  }
}
