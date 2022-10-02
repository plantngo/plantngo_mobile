// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchant _$MerchantFromJson(Map<String, dynamic> json) => Merchant(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      company: json['company'] as String?,
      token: json['token'] as String,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJSON(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'company': instance.company,
      'token': instance.token,
      'categories': instance.categories,
    };
