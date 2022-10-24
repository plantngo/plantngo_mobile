import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/product.dart';

part "category.g.dart";

@JsonSerializable(explicitToJson: true)
class Category {
  int? id;
  String name;
  List<Product>? products;

  Category({required this.id, required this.name, required this.products});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
