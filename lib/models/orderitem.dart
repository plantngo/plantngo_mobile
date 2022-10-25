import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/product.dart';

part "orderitem.g.dart";

@JsonSerializable()
class OrderItem {
  int? id;

  int? productId;

  int? quantity;

  double? price;

  Order? order;

  Product? product;

  OrderItem(
      {required this.id,
      required this.productId,
      required this.quantity,
      required this.price,
      required this.order,
      required this.product});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
