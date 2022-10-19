import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../utils/error_handling.dart';
import '../utils/global_variables.dart';

class UserService {
  static void updateCustomerDetails(
    BuildContext context,
    String? oldUserName,
    String? newUserName,
    String email,
  ) async {
    try {
      if (oldUserName == newUserName) {
        newUserName = null;
      }
      http.Response res = await http.put(
        Uri.parse('$uri/api/v1/customer/$oldUserName'),
        body: jsonEncode({
          "username": newUserName,
          "email": email,
          "password": null,
          "greenPoints": null,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Change Successful!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static void updateMerchantDetails(
    BuildContext context,
    String? oldUserName,
    String? newUserName,
    String email,
    String company
  ) async {
    try {
      if (oldUserName == newUserName) {
        newUserName = null;
      }
      http.Response res = await http.put(
        Uri.parse('$uri/api/v1/merchant/$oldUserName'),
        body: jsonEncode({
          "username": newUserName,
          "email": email,
          "password": null,
          "company": company,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Change Successful!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static void changePassword(
    BuildContext context,
    String newPassword,
    String password,
    String username,
    String userType,
  ) async {
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/v1/edit-profile/password'),
        body: jsonEncode({
          "newUserName": null,
          "newPassword": newPassword,
          "username": username,
          "password": password,
          "userType": userType,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Change Successful!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
