import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/models/product.dart';

part "merchant.g.dart";

@JsonSerializable()
class Merchant {
  int? id;
  String? username;
  String? email;
  String? company;
  String token;
  List<Category>? categories;

  Merchant(
      {required this.id,
      required this.username,
      required this.email,
      required this.company,
      required this.token,
      required this.categories});

  factory Merchant.fromJSON(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);

  Map<String, dynamic> toJSON() => _$MerchantToJson(this);
}
