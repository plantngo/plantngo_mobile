// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as int?,
      productId: json['productId'] as int?,
      quantity: json['quantity'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'price': instance.price,
      'order': instance.order,
      'product': instance.product,
    };
