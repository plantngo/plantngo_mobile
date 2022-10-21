import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/product.dart';

part 'promotion.g.dart';

@JsonSerializable()
class Promotion {
  int? id;
  String? description;
  //url to link to the promotional banner image
  String? banner; 
  double? percentageDiscount;
  //derived from date of promo creation
  String? startDate;
  String? endDate;
  //selected products on promotion
  List<Product>? products;

  Promotion({
    required this.id,
    required this.description,
    required this.banner,
    required this.percentageDiscount,
    required this.startDate,
    required this.endDate,
    required this.products
  });

  factory Promotion.fromJSON(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJSON() => _$PromotionToJson(this);
}
