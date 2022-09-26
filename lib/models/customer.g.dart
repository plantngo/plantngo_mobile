// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      greenPoints: json['greenPoints'] as int?,
      token: json['token'] as String,
      preference: (json['preference'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'greenPoints': instance.greenPoints,
      'token': instance.token,
      'preference': instance.preference,
    };
