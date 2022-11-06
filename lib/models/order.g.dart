// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      isDineIn: json['isDineIn'] as bool?,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderStatus: json['orderStatus'] as String?,
      merchant: json['merchant'] == null
          ? null
          : MerchantShallow.fromJson(json['merchant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'isDineIn': instance.isDineIn,
      'orderItems': instance.orderItems,
      'orderStatus': instance.orderStatus,
      'merchant': instance.merchant,
    };
