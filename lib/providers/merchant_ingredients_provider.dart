import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/ingredient.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';

class MerchantIngredientsProvider extends ChangeNotifier {
  List<Ingredient> _ingredients = [];

  List<Ingredient> get ingredient => _ingredients;

  setIngredients(List<Ingredient> ingredients) {
    _ingredients = ingredients;
    notifyListeners();
  }
}
