import 'package:json_annotation/json_annotation.dart';

part 'merchant_search.g.dart';

@JsonSerializable()
class MerchantSearch {
  int id;
  String company;
  String logoUrl;
  String bannerUrl;
  String address;
  double latitude;
  double longtitude;
  String cuisineType;
  int priceRating;
  String operatingHours;
  String description;

  @JsonKey(ignore: true)
  double? distanceFrom;

  // reviews? optional

  MerchantSearch({
    required this.id,
    required this.company,
    required this.logoUrl,
    required this.bannerUrl,
    required this.address,
    required this.latitude,
    required this.longtitude,
    required this.cuisineType,
    required this.priceRating,
    required this.operatingHours,
    required this.description,
    this.distanceFrom,
  });

  factory MerchantSearch.fromJSON(Map<String, dynamic> json) =>
      _$MerchantSearchFromJson(json);

  Map<String, dynamic> toJSON() => _$MerchantSearchToJson(this);
}
