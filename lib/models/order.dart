import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/customer.dart';
import 'package:plantngo_frontend/models/merchant.dart';
import 'package:plantngo_frontend/models/orderitem.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int? id;

  double? totalPrice;

  bool? isDineIn;

  List<OrderItem>? orderItems;

  String? orderStatus;

  Order(
      {required this.id,
      required this.totalPrice,
      required this.isDineIn,
      required this.orderItems,
      required this.orderStatus});

  Order.createOrder({
    required this.isDineIn,
    required this.orderItems,
    required this.orderStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
