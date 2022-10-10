// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantSearch _$MerchantSearchFromJson(Map<String, dynamic> json) =>
    MerchantSearch(
      id: json['id'] as int,
      company: json['company'] as String,
      logoUrl: json['logoUrl'] as String,
      bannerUrl: json['bannerUrl'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longtitude: (json['longtitude'] as num).toDouble(),
      cuisineType: json['cuisineType'] as String,
      priceRating: json['priceRating'] as int,
      operatingHours: json['operatingHours'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$MerchantSearchToJson(MerchantSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'logoUrl': instance.logoUrl,
      'bannerUrl': instance.bannerUrl,
      'address': instance.address,
      'latitude': instance.latitude,
      'longtitude': instance.longtitude,
      'cuisineType': instance.cuisineType,
      'priceRating': instance.priceRating,
      'operatingHours': instance.operatingHours,
      'description': instance.description,
    };
