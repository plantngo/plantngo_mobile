import 'dart:convert';

import '../models/merchant.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class MerchantProvider extends ChangeNotifier {
  Merchant _merchant = Merchant(
      id: null, username: '', email: '', token: '', company: '', products: []);

  Merchant get merchant => _merchant;

  void setMerchant(String merchant, String token) {
    Map<String, dynamic> merchantMap = jsonDecode(merchant)[0];
    merchantMap['token'] = token;
    print(merchantMap['products'][0]);
    // print(
    // merchantMap['products'][0]?.map((x) => Product.fromJSON(x['product'])));
    _merchant = Merchant.fromJSON(merchantMap);
    notifyListeners();
  }

  void setMerchantFromModel(Merchant merchant) {
    _merchant = merchant;
    notifyListeners();
  }

  void resetMerchant() {
    _merchant = Merchant(
      id: null,
      username: '',
      email: '',
      token: '',
      company: '',
      products: [],
    );
  }
}
