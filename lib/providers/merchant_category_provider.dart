import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';

class MerchantCategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  setCategories(BuildContext context) async {
    _categories = await MerchantService.fetchAllCategories(context);
    notifyListeners();
  }
}
