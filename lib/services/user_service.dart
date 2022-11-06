import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/screens/login/reset_password_screen.dart';
import 'package:provider/provider.dart';

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
          var customerProvider =
              Provider.of<CustomerProvider>(context, listen: false);
          if (newUserName != null) {
            customerProvider.customer.username = newUserName;
          }
          if (email != null) {
            customerProvider.customer.email = email;
          }
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
      String company,
      String cuisineType,
      String description,
      String operatingHours) async {
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
          "cuisineType": cuisineType,
          "description": description,
          "operatingHours": operatingHours
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var merchantProvider =
              Provider.of<MerchantProvider>(context, listen: false);
          if (newUserName != null) {
            merchantProvider.merchant.username = newUserName;
          }
          if (email != null) {
            merchantProvider.merchant.email = email;
          }
          if (company != null) {
            merchantProvider.merchant.company = company;
          }
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

  static void getResetPasswordToken(
    BuildContext context,
    String email,
  ) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/forgot-password/token'),
        body: jsonEncode({
          "email": email,
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
            'Reset Token Sent to Email!',
          );
        },
      );
    } catch (e) {}
  }

  static void resetPasswordWithToken(
    BuildContext context,
    String email,
    String resetPasswordToken,
    String newPassword,
  ) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/forgot-password/'),
        body: jsonEncode({
          "email": email,
          "resetPasswordToken": resetPasswordToken,
          "newPassword": newPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Password Reset Successful!");
          Navigator.pushNamed(context, '/login');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
