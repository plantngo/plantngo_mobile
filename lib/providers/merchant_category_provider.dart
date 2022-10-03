import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';

class MerchantCategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  MerchantService merchantService = MerchantService();

  setCategories(BuildContext context) async {
    _categories = await merchantService.fetchAllCategories(context);
    notifyListeners();
  }
}
