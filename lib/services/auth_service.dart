import 'dart:ffi';

import 'package:flutter/material.dart';
import '../utils/global_variables.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_form.dart';
import '../providers/auth_provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
    required String username,
    required String accType,
  }) async {
    try {
      User user = User(
          username: username,
          name: name,
          email: email,
          password: password,
          acctype: '',
          address: '',
          token: '',
          greenPoints: 0,
          preferences: []);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // httpErrorHandle()
    } catch (e) {
      //some exception
    }
  }

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
    } catch (e) {}
  }
}
