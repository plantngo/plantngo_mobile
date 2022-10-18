import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/models/voucher.dart';

part "merchant.g.dart";

@JsonSerializable()
class Merchant {
  int? id;
  String? username;
  String? email;
  String? company;
  String token;
  List<Category>? categories;
  List<Voucher>? vouchers;
  String? logoUrl;
  String? bannerUrl;
  String? address;
  String? description;
  double? latitude;
  double? longtitude;
  String? cuisineType;
  int? priceRating;
  String? operatingHours;

  Merchant(
      {required this.id,
      required this.username,
      required this.email,
      required this.company,
      required this.token,
      required this.categories,
      required this.vouchers,
      required this.logoUrl,
      required this.bannerUrl,
      required this.address,
      required this.description,
      required this.latitude,
      required this.longtitude,
      required this.cuisineType,
      required this.priceRating,
      required this.operatingHours});

  factory Merchant.fromJSON(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);

  Map<String, dynamic> toJSON() => _$MerchantToJson(this);
}
