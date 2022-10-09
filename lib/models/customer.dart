import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/voucher.dart';

part "customer.g.dart";

@JsonSerializable()
class Customer {
  int? id;
  String? username;
  String? email;
  int? greenPoints;
  String token;
  List<String>? preference;
  List<Voucher> ownedVouchers;
  List<Voucher> vouchersCart;

  Customer(
      {required this.id,
      required this.username,
      required this.email,
      required this.greenPoints,
      required this.token,
      required this.preference,
      required this.ownedVouchers,
      required this.vouchersCart
      });

  factory Customer.fromJSON(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJSON() => _$CustomerToJson(this);
}
