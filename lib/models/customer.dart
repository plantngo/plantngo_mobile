import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:quiver/core.dart';

part "customer.g.dart";

@JsonSerializable(explicitToJson: true)
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
      required this.vouchersCart});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  bool operator ==(o) => o is Customer && username == o.username && id == o.id;
  int get hashCode => hash2(username.hashCode, id.hashCode);
}
