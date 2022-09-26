// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchant _$MerchantFromJson(Map<String, dynamic> json) => Merchant(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      company: json['company'] as int?,
      token: json['token'] as String,
    );

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'company': instance.company,
      'token': instance.token,
    };
