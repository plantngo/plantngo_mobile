import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isAnonymousUser = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get isAnonymousUser => _isAnonymousUser;

  void fakeLogin() {
    _isLoggedIn = true;
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
