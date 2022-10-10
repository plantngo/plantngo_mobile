import 'dart:convert';

import '../models/customer.dart';
import 'package:flutter/material.dart';

import '../models/voucher.dart';
import '../services/customer_service.dart';

class CustomerProvider extends ChangeNotifier {
  Customer _customer = Customer(
    id: null,
    username: '',
    email: '',
    token: '',
    greenPoints: 0,
    preference: [],
    ownedVouchers: [],
    vouchersCart: [],
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
      ownedVouchers: [],
      vouchersCart: [],
    );
  }

  void setVoucherCart(BuildContext context) async {
    customer.vouchersCart =
        await CustomerService.fetchAllVouchersInCart(context);
    notifyListeners();
  }

  void addVouchersToCart(BuildContext context, Voucher v) {
    CustomerService.addVoucherToCart(context, v);
    notifyListeners();
  }

  void removeVouchersFromCart(BuildContext context, Voucher v) {
    CustomerService.removeVoucherFromCart(context, v);
    notifyListeners();
  }
}
