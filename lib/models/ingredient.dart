import 'package:json_annotation/json_annotation.dart';

part "ingredient.g.dart";

@JsonSerializable()
class Ingredient {
  int? id;
  String? name;
  double? servingQty;

  Ingredient(
      {required this.id,
      required this.name,
      required this.servingQty});

  factory Ingredient.fromJSON(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJSON() => _$IngredientToJson(this);
}
