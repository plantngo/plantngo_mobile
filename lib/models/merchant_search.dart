import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/category.dart';

part 'merchant_search.g.dart';

@JsonSerializable()
class MerchantSearch {
  int id;
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
  List<Category>? categories;

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
    required this.longitude,
    required this.cuisineType,
    required this.priceRating,
    required this.operatingHours,
    required this.description,
    required this.categories,
    this.distanceFrom,
  });

  factory MerchantSearch.fromJSON(Map<String, dynamic> json) =>
      _$MerchantSearchFromJson(json);

  Map<String, dynamic> toJSON() => _$MerchantSearchToJson(this);
}
