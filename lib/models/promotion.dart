import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promotion.g.dart';

@JsonSerializable()
class Promotion {
  int? id;
  String? description;
  String? banner;
  double? percentageDiscount;
  String? startDate;
  String? endDate;

  Promotion({
    required this.id,
    required this.description,
    required this.banner,
    required this.percentageDiscount,
    required this.startDate,
    required this.endDate
  });

  factory Promotion.fromJSON(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJSON() => _$PromotionToJson(this);
}
