// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      productName: json['productName'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      picture: json['picture'] as String,
      carbonFootprint: (json['carbonFootprint'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'description': instance.description,
      'price': instance.price,
      'picture': instance.picture,
      'carbonFootprint': instance.carbonFootprint,
    };
