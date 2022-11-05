import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/category.dart';

part 'merchant_shallow.g.dart';

@JsonSerializable(explicitToJson: true)
class MerchantShallow {
  int id;
  String username;
  String company;
  String logoUrl;
  String bannerUrl;
  String address;
  double latitude;
  double longitude;
  String cuisineType;
  int priceRating;
  String operatingHours;
  String description;
  double? carbonRating;

  // reviews? optional

  MerchantShallow({
    required this.id,
    required this.username,
    required this.company,
    required this.logoUrl,
    required this.bannerUrl,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.cuisineType,
    required this.priceRating,
    required this.operatingHours,
    required this.description,
    this.carbonRating,
  });

  factory MerchantShallow.fromJson(Map<String, dynamic> json) =>
      _$MerchantShallowFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantShallowToJson(this);
}
