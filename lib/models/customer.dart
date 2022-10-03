import 'package:json_annotation/json_annotation.dart';

part "customer.g.dart";

@JsonSerializable()
class Customer {
  int? id;
  String? username;
  String? email;
  int? greenPoints;
  String token;
  List<String>? preference;

  Customer(
      {required this.id,
      required this.username,
      required this.email,
      required this.greenPoints,
      required this.token,
      required this.preference});

  factory Customer.fromJSON(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJSON() => _$CustomerToJson(this);
}
