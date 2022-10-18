import 'package:json_annotation/json_annotation.dart';

part "ingredient.g.dart";

@JsonSerializable()
class Ingredient {
  int? id;
  String? ingredientId;
  String? name;
  String? category;
  double? emissionPerGram;
  double? servingWeight;

  Ingredient(
      {required this.id,
      required this.ingredientId,
      required this.category,
      required this.name,
      required this.emissionPerGram,
      required this.servingWeight});

  factory Ingredient.fromJSON(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJSON() => _$IngredientToJson(this);
}
