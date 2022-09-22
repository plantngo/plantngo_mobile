import 'dart:convert';

import '../models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    username: '',
    email: '',
    password: '',
    acctype: '',
    address: '',
    token: '',
    greenPoints: 0,
    preferences: [],
  );

  User get user => _user;

  void setUser(String user) {
    Map<String, dynamic> userMap = jsonDecode(user);
    _user = User.fromJSON(userMap);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
