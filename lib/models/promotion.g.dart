// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      id: json['id'] as int?,
      description: json['description'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      percentageDiscount: (json['percentageDiscount'] as num?)?.toDouble(),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJSON(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'banner': instance.bannerUrl,
      'percentageDiscount': instance.percentageDiscount,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'products': instance.products,
    };
