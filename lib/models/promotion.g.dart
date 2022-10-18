// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      id: json['id'] as int,
      description: json['description'] as String?,
      merchant: Merchant.fromJSON(json['merchant'] as Map<String, dynamic>),
      promoProducts: (json['promoProducts'] as List<dynamic>)
          .map((e) => Product.fromJSON(e as Map<String, dynamic>))
          .toList(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      percentageDiscount: (json['percentageDiscount'] as num).toDouble(),
      bannerUrl: json['bannerUrl'] as String,
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'merchant': instance.merchant,
      'promoProducts': instance.promoProducts,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'percentageDiscount': instance.percentageDiscount,
      'bannerUrl': instance.bannerUrl,
    };
