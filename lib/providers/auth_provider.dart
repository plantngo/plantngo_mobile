import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_form.dart';
import '../services/login_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isAnonymousUser = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get isAnonymousUser => _isAnonymousUser;

  var httpClient = http.Client();

  Future login(LoginForm loginForm) async {
    var result = await LogInService().userLogIn(loginForm);
    if (result.statusCode == 200) {
      _isLoggedIn = true;
      print(result.body);
    }
    notifyListeners();
  }

  void fakeLogout() {
    _isLoggedIn = false;
    _isAnonymousUser = false;
    notifyListeners();
  }

  void fakeAnonymousLogin() {
    _isLoggedIn = true;
    _isAnonymousUser = true;
    notifyListeners();
  }
}
