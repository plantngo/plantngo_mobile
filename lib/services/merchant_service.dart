import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:provider/provider.dart';
import '../utils/global_variables.dart';
import '../utils/user_secure_storage.dart';

class MerchantService {
  void editCategory(
      {required String oldCategoryName,
      required String newCategoryName,
      required BuildContext context}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    try {
      http.Response res = await http.post(
          Uri.parse(
              '$uri/api/v1/merchant/${merchantProvider.merchant.username}/$oldCategoryName'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({"name": newCategoryName}));
    } catch (e) {
      //todo exception

    }
  }

  Future deleteCategory(
      {required BuildContext context, required String category}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    try {
      http.Response res = await http.delete(
          Uri.parse(
              '$uri/api/v1/merchant/${merchantProvider.merchant.username}/$category'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
    } catch (e) {
      //todo exception
    }
  }

  Future<List<Category>> fetchAllCategories(BuildContext context) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    List<Category> categories = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/merchant/${merchantProvider.merchant.username}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (res.statusCode == 200) {
        for (var i = 0; i < jsonDecode(res.body)["categories"].length; i++) {
          categories
              .add(Category.fromJSON(jsonDecode(res.body)["categories"][i]));
        }
      }
    } catch (e) {
      //to do catch exception
    }

    return categories;
  }
}
