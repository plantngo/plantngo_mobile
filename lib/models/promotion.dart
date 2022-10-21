import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/product.dart';
import 'merchant.dart';

part 'promotion.g.dart';

@JsonSerializable()
class Promotion {
  int id;
  String? description;
  List<Product> promoProducts;
  String startDate;
  String endDate;
  double percentageDiscount;
  String bannerUrl;

  Promotion({
    required this.id,
    required this.description,
    required this.promoProducts,
    required this.startDate,
    required this.endDate,
    required this.percentageDiscount,
    required this.bannerUrl,
  });
  factory Promotion.fromJSON(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJSON() => _$PromotionToJson(this);

  @override
  String toString() {
    return toJSON().toString();
  }

  static fromJson(Map<String, dynamic> e) {}
}
