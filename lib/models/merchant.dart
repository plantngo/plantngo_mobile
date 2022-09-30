import 'package:json_annotation/json_annotation.dart';

part "merchant.g.dart";

@JsonSerializable()
class Merchant {
  int? id;
  String? username;
  String? email;
  String? company;
  String token;
  List<int>? product;

  Merchant(
      {required this.id,
      required this.username,
      required this.email,
      required this.company,
      required this.token,
      required this.product});

  factory Merchant.fromJSON(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);

  Map<String, dynamic> toJSON() => _$MerchantToJson(this);
}
