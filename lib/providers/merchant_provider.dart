import 'dart:convert';
import 'package:plantngo_frontend/models/voucher.dart';

import '../models/merchant.dart';
import 'package:flutter/material.dart';

class MerchantProvider extends ChangeNotifier {
  Merchant _merchant = Merchant(
      id: null,
      username: '',
      email: '',
      company: '',
      token: '',
      categories: [],
      vouchers: [],
      promotions: [],
      logoUrl: '',
      bannerUrl: '',
      address: '',
      description: '',
      latitude: null,
      longtitude: null,
      cuisineType: '',
      priceRating: null,
      operatingHours: '');

  Merchant get merchant => _merchant;

  void setMerchant(String merchant, String token) {
    Map<String, dynamic> merchantMap = jsonDecode(merchant);
    merchantMap['token'] = token;
    _merchant = Merchant.fromJson(merchantMap);
    notifyListeners();
  }

  void setMerchantFromModel(Merchant merchant) {
    _merchant = merchant;
    notifyListeners();
  }

  void setVouchers(List<Voucher> vouchers) {
    _merchant.vouchers = vouchers;
    notifyListeners();
  }

  void resetMerchant() {
    _merchant = Merchant(
        id: null,
        username: '',
        email: '',
        company: '',
        token: '',
        categories: [],
        vouchers: [],
        promotions: [],
        logoUrl: '',
        bannerUrl: '',
        address: '',
        description: '',
        latitude: null,
        longtitude: null,
        cuisineType: '',
        priceRating: null,
        operatingHours: '');
  }
}
