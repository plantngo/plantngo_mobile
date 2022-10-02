import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  double? carbonEmission;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.carbonEmission});

  factory Product.fromJSON(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJSON() => _$ProductToJson(this);
}
