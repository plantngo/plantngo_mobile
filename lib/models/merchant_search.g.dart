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
      longitude: (json['longitude'] as num).toDouble(),
      cuisineType: json['cuisineType'] as String,
      priceRating: json['priceRating'] as int,
      operatingHours: json['operatingHours'] as String,
      description: json['description'] as String,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJSON(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MerchantSearchToJson(MerchantSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'logoUrl': instance.logoUrl,
      'bannerUrl': instance.bannerUrl,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'cuisineType': instance.cuisineType,
      'priceRating': instance.priceRating,
      'operatingHours': instance.operatingHours,
      'description': instance.description,
      'categories': instance.categories,
    };
