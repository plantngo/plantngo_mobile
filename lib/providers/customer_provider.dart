import 'dart:convert';

import '../models/customer.dart';
import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier {
  Customer _customer = Customer(
    id: null,
    username: '',
    email: '',
    token: '',
    greenPoints: 0,
    preference: [],
  );

  Customer get customer => _customer;

  void setCustomer(String customer, String token) {
    Map<String, dynamic> customerMap = jsonDecode(customer)[0];
    customerMap['token'] = token;
    _customer = Customer.fromJSON(customerMap);
    notifyListeners();
  }

  void setCustomerFromModel(Customer customer) {
    _customer = customer;
    notifyListeners();
  }

  void resetCustomer() {
    _customer = Customer(
      id: null,
      username: '',
      email: '',
      token: '',
      greenPoints: 0,
      preference: [],
    );
  }
}
