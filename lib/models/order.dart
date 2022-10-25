import 'package:json_annotation/json_annotation.dart';
import 'package:plantngo_frontend/models/customer.dart';
import 'package:plantngo_frontend/models/merchant.dart';
import 'package:plantngo_frontend/models/orderitem.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int? id;

  int? customer_Id;

  double? totalPrice;

  bool? isDineIn;

  List<OrderItem>? orderItems;

  Customer? customer;

  Merchant? merchant;

  Order(
      {required this.id,
      required this.customer_Id,
      required this.totalPrice,
      required this.isDineIn,
      required this.orderItems,
      required this.customer,
      required this.merchant});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
