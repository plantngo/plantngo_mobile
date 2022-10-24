import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/ingredient.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';
import 'package:plantngo_frontend/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../utils/global_variables.dart';

class ProductService {
  static Future addIngredient(
      {required String productName,
      required String ingredientName,
      required double servingWeight,
      required BuildContext context}) async {
    String? token = await UserSecureStorage.getToken();

    MerchantProvider merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
          Uri.parse(
              '$uri/api/v1/product/${merchantProvider.merchant.username}/$productName'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(
              {"name": ingredientName, "servingQty": servingWeight}));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future deleteAllIngredients(
      {required String productName, required BuildContext context}) async {
    String? token = await UserSecureStorage.getToken();

    MerchantProvider merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);

    try {
      await http.delete(
          Uri.parse(
              '$uri/api/v1/product/${merchantProvider.merchant.username}/$productName'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
    } catch (e) {
      //todo
    }
  }

  static Future<List<Ingredient>> getAllIngredientsByMerchantAndProduct(
      {required BuildContext context, required String productName}) async {
    String? token = await UserSecureStorage.getToken();
    List<Ingredient> ingredients = [];

    MerchantProvider merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
          Uri.parse(
              '$uri/api/v1/product/${merchantProvider.merchant.username}/$productName'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            json
                .decode(res.body)
                .map((e) => {
                      ingredients.add(Ingredient.fromJson({
                        "id": e["id"],
                        "servingQty": e["servingQty"],
                        "name": e["ingredient"]["name"]
                      }))
                    })
                .toList();
          });
    } catch (e) {
      //todo
      print(e);
    }

    return ingredients;
  }
}
