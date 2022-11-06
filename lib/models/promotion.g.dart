// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      id: json['id'] as int?,
      description: json['description'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      clicks: json['clicks'] as int?,
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'bannerUrl': instance.bannerUrl,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'clicks': instance.clicks,
    };
