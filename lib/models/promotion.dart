import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/product.dart';

part 'promotion.g.dart';

@JsonSerializable()
class Promotion {
  int? id;
  String? description;
  //url to link to the promotional banner image
  String? bannerUrl;
  //derived from date of promo creation
  String? startDate;
  String? endDate;

  Promotion({
    required this.id,
    required this.description,
    required this.bannerUrl,
    required this.startDate,
    required this.endDate,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}
