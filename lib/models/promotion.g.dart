// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      id: json['id'] as int?,
      description: json['description'] as String?,
      banner: json['banner'] as String?,
      percentageDiscount: (json['percentageDiscount'] as num?)?.toDouble(),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'banner': instance.banner,
      'percentageDiscount': instance.percentageDiscount,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
