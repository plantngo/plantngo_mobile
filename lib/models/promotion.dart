import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/product.dart';
import 'package:quiver/core.dart';

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
  int? clicks;

  Promotion(
      {required this.id,
      required this.description,
      required this.bannerUrl,
      required this.startDate,
      required this.endDate,
      required this.clicks});

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  bool operator ==(o) =>
      o is Promotion && id == o.id && description == o.description;
  int get hashCode => hash2(id.hashCode, description.hashCode);
}
