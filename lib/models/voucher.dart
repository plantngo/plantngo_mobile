import 'package:json_annotation/json_annotation.dart';

import 'merchant.dart';

part 'voucher.g.dart';

@JsonSerializable()
class Voucher {
  int? id;
  String? name;
  String? description;
  double? value;
  String? type;
  double? discount;
  int? merchantId;

  Voucher({
    required this.id,
    required this.description,
    required this.value,
    required this.discount,
    required this.type,
    required this.merchantId
  });
  factory Voucher.fromJSON(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);

  Map<String, dynamic> toJSON() => _$VoucherToJson(this);

  @override
  String toString(){
    return toJSON().toString();
  }

  static fromJson(Map<String, dynamic> e) {}
}
