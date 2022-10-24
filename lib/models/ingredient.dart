import 'package:json_annotation/json_annotation.dart';

part "ingredient.g.dart";

@JsonSerializable()
class Ingredient {
  int? id;
  String? name;
  double? servingQty;

  Ingredient({required this.id, required this.name, required this.servingQty});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
