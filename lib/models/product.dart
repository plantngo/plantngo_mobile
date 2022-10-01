import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int id;
  String productName;
  String description;
  double price;
  String picture;
  double carbonFootprint;

  Product(
      {required this.id,
      required this.productName,
      required this.description,
      required this.price,
      required this.picture,
      required this.carbonFootprint});

  factory Product.fromJSON(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJSON() => _$ProductToJson(this);
}
