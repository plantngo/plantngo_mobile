// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voucher _$VoucherFromJson(Map<String, dynamic> json) => Voucher(
      id: json['id'] as int?,
      description: json['description'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      type: json['type'] as String?,
      merchantId: json['merchantId'] as int,
    )..name = json['name'] as String?;

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'type': instance.type,
      'discount': instance.discount,
      'merchantId': instance.merchantId,
    };
