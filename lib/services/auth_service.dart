import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:plantngo_frontend/utils/all.dart';
import 'package:provider/provider.dart';
import '../utils/global_variables.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/user_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';

class AuthService {
  //signup customer and redirect to login page
  static void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String username,
      required String userType,
      required}) async {
    try {
      print("$email $username $password $userType");
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/register'),
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "userType": userType,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static void signUpMerchant(
      {required BuildContext context,
      required String email,
      required String password,
      required String username,
      required String userType,
      required String company,
      required String address,
      required double latitude,
      required double longitude}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/register'),
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "userType": userType,
          "company": company,
          "address": address,
          "latitude": latitude,
          "longitude": longitude
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
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //first time sign in user(both customer and merchant
  static signInUser({
    required BuildContext context,
    required String username,
    required String password,
    required String userType,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/login'),
        body: jsonEncode({
          'username': username,
          'password': password,
          'userType': userType,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          UserSecureStorage.setToken(res.headers['jwt'].toString());

          getUserData(context);
          if (userType == "C") {
            Navigator.pushNamedAndRemoveUntil(
                context, CustomerApp.routeName, (route) => false);
          }

          if (userType == "M") {
            Navigator.pushNamedAndRemoveUntil(
                context, MerchantApp.routeName, (route) => false);
          }
          showSnackBar(
            context,
            'Signed In',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data to check if it has been logged in
  static void getUserData(
    BuildContext context,
  ) async {
    try {
      var customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      var merchantProvider =
          Provider.of<MerchantProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();

      if (token == null || token == "") {
        UserSecureStorage.setToken("");
      } else {
        Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
        String username = payload['sub'];
        String userType = payload['Authority'].toLowerCase();

        http.Response userRes = await http.get(
          Uri.parse('$uri/api/v1/$userType/$username'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
        );

        if (userRes.statusCode != 200) {
          logOut(context);
        }

        if (userType == "customer") {
          customerProvider.setCustomer(userRes.body, token);
        }

        if (userType == "merchant") {
          merchantProvider.setMerchant(userRes.body, token);
          await MerchantService.fetchAllVouchers(context);
          await MerchantService.fetchAllIngredients(context);
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static void logOut(BuildContext context) async {
    var customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    var merchantProvider =
        Provider.of<MerchantProvider>(context, listen: false);
    try {
      UserSecureStorage.deleteAll();
      customerProvider.resetCustomer();
      merchantProvider.resetMerchant();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const LoginSignUpScreen()),
          (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
