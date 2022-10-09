import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/product.dart';

part "category.g.dart";

@JsonSerializable()
class Category {
  int? id;
  String name;
  List<Product>? products;
  

  Category({required this.id, required this.name, required this.products});

  factory Category.fromJSON(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJSON() => _$CategoryToJson(this);
}
