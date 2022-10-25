// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int?,
      customer_Id: json['customer_Id'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      isDineIn: json['isDineIn'] as bool?,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      merchant: json['merchant'] == null
          ? null
          : Merchant.fromJson(json['merchant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'customer_Id': instance.customer_Id,
      'totalPrice': instance.totalPrice,
      'isDineIn': instance.isDineIn,
      'orderItems': instance.orderItems,
      'customer': instance.customer,
      'merchant': instance.merchant,
    };
