import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/global_variables.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/user_secure_storage.dart';
import '../providers/user_provider.dart';

class AuthService {
  //signup user and redirect to login page
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
    required String userType,
  }) async {
    try {
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

      print(res.body);
      // httpErrorHandle()
    } catch (e) {
      //some exception
      print(e);
    }
  }

  void signUpMerchant(
      {required BuildContext context,
      required String email,
      required String password,
      required String username,
      required String userType,
      required String company}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/register'),
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "userType": userType,
          "company": company
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(res.body);
      // httpErrorHandle()
    } catch (e) {
      //some exception
      print(e);
    }
  }

  //first time sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/auth/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      UserSecureStorage.setToken(jsonDecode(res.body)['token']);
    } catch (e) {
      // catch error
    }
  }

  //get user data to check if it has been logged in and token expiry
  void getUserData(
    BuildContext context,
  ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();

      print('Bearer $token');
      if (token == null) {
        UserSecureStorage.setToken("");
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer' + '$token!',
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token!'
          },
        );

        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      //handle error
      // showSnackBar(context, e.toString());
    }
  }
}
