import 'package:flutter/material.dart';
import '../models/promotion.dart';
import '../services/promotion_service.dart';
import '../services/shop_service.dart';

class PromotionProvider extends ChangeNotifier {
  List<Promotion> _promotions = [];

  List<Promotion> get promotions => _promotions;

  Future<List<Promotion>> setPromotions(BuildContext context) async {
    _promotions = await PromotionService.fetchAllPromotions(context);
    notifyListeners();
    return _promotions;
  }
}
