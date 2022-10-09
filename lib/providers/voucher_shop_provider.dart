import 'package:flutter/material.dart';
import '../models/voucher.dart';
import '../services/shop_service.dart';

class VoucherShopProvider extends ChangeNotifier {
  List<Voucher> _vouchers = [];

  List<Voucher> get vouchers => _vouchers;

  setVouchers(BuildContext context) async {
    _vouchers = await ShopService.fetchAllVouchers(context);
    notifyListeners();
  }
}
