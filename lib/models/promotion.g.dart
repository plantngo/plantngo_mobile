// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      id: json['id'] as int,
      description: json['description'] as String?,
      promoProducts: (json['promoProducts'] as List<dynamic>)
          .map((e) => Product.fromJSON(e as Map<String, dynamic>))
          .toList(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      percentageDiscount: (json['percentageDiscount'] as num).toDouble(),
      bannerUrl: json['bannerUrl'] as String,
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'promoProducts': instance.promoProducts,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'percentageDiscount': instance.percentageDiscount,
      'bannerUrl': instance.bannerUrl,
    };
