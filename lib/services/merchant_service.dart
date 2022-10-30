import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/models/ingredient.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:plantngo_frontend/providers/merchant_ingredients_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:provider/provider.dart';
import '../utils/global_variables.dart';
import '../utils/user_secure_storage.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';

class MerchantService {
  static Future editCategory(
      {required String oldCategoryName,
      required String newCategoryName,
      required BuildContext context}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    try {
      http.Response res = await http.put(
          Uri.parse(
              '$uri/api/v1/merchant/${merchantProvider.merchant.username}/$oldCategoryName'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({"name": newCategoryName}));
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
      showSnackBar(context, e.toString());
    }
  }

  static Future deleteCategory(
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
      showSnackBar(context, e.toString());
    }
  }

  static Future addCategory(
      {required BuildContext context, required String category}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    try {
      http.Response res = await http.post(
          Uri.parse(
              '$uri/api/v1/merchant/${merchantProvider.merchant.username}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({"name": category}));
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
      //catch exception
    }
  }

  static Future addProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required String category}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();
    try {
      http.Response res = await http.post(
          Uri.parse(
              '$uri/api/v1/merchant/${merchantProvider.merchant.username}/$category'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "name": name,
            "price": price,
            "description": description,
          }));

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
      //catch exception
      print(e);
    }
  }

  static Future editProduct(
      {required BuildContext context,
      required String oldName,
      required String newName,
      required String description,
      required double price,
      required String category}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();
    try {
      http.Response res = await http.put(
          Uri.parse(
              '$uri/api/v1/merchant/${merchantProvider.merchant.username}/$category/$oldName'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "name": newName,
            "price": price,
            "description": description,
          }));
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
      //catch exception
    }
  }

  static Future deleteProduct(
      {required BuildContext context,
      required String name,
      required String category}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();
    try {
      http.Response res = await http.delete(
          Uri.parse(
              '$uri/api/v1/merchant/${merchantProvider.merchant.username}/$category/$name'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        print('delete product');
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
      //catch exception
    }
  }

  static Future<List<Category>> fetchAllCategories(BuildContext context) async {
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
              .add(Category.fromJson(jsonDecode(res.body)["categories"][i]));
        }
      }
    } catch (e) {
      //to do catch exception
    }

    return categories;
  }

  static Future<File?> pickImage() async {
    dynamic image;
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (files != null && files.files.isNotEmpty) {
        image = File(files.files.first.path!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return image;
  }

  static Future createVoucher(
      {required BuildContext context,
      required double value,
      required double discount,
      required String description,
      required String type}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    try {
      http.Response res = await http.post(
          Uri.parse(
              '$uri/api/v1/merchant/${merchantProvider.merchant.username}/vouchers'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "value": value,
            "discount": discount,
            "description": description,
            "type": type
          }));
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
      //catch exception
    }
  }

  static Future editVoucher(
      {required BuildContext context,
      required int id,
      required double value,
      required double discount,
      required String description,
      required String type}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    try {
      http.Response res = await http.put(
          Uri.parse(
              '$uri/api/v1/merchant/${merchantProvider.merchant.username}/vouchers/$id'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "value": value,
            "discount": discount,
            "description": description,
            "type": type
          }));
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
      //catch exception
    }
  }

  static Future deleteVoucher(
      {required BuildContext context, required int id}) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    try {
      http.Response res = await http.delete(
        Uri.parse(
            '$uri/api/v1/merchant/${merchantProvider.merchant.username}/vouchers/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
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
      //catch exception
    }
  }

  static Future<List<Voucher>> fetchAllVouchers(BuildContext context) async {
    final merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    List<Voucher> vouchers = [];

    try {
      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/v1/merchant/${merchantProvider.merchant.username}/vouchers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          json
              .decode(res.body)
              .map((e) => {vouchers.add(Voucher.fromJson(e))})
              .toList();
          Provider.of<MerchantProvider>(context, listen: false)
              .setVouchers(vouchers);
        },
      );
    } catch (e) {
      //to do catch exception
    }

    return [];
  }

  static Future fetchAllIngredients(BuildContext context) async {
    try {
      List<Ingredient> ingredients = [];
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/ingredient'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          json
              .decode(res.body)
              .map((e) => {ingredients.add(Ingredient.fromJson(e))})
              .toList();
          Provider.of<MerchantIngredientsProvider>(context, listen: false)
              .setIngredients(ingredients);
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
