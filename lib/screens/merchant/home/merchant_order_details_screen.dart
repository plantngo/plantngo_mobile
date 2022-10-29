//todo add item picture?
import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/product.dart';

class MerchantOrderDetailsScreen extends StatefulWidget {
  const MerchantOrderDetailsScreen({Key? key, required this.order})
      : super(key: key);

  final Order order;
  @override
  _MerchantOrderDetailsScreenState createState() =>
      _MerchantOrderDetailsScreenState();
}

class _MerchantOrderDetailsScreenState
    extends State<MerchantOrderDetailsScreen> {
  List<Product> orderItems = [];

  @override
  void initState() {
    super.initState();
  }

  getOrderItems() async {
    for (var item in widget.order.orderItems!) {
      
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order ID: ${widget.order.id}"),
      ),
      body: ListView(

      ),
    );
  }
}
