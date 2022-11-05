import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/orderitem.dart';
import 'package:plantngo_frontend/screens/customer/cart/cart_screen.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_about_section.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_bottom_app_bar.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_menu_section.dart';
import 'package:plantngo_frontend/services/customer_order_service.dart';
import 'package:plantngo_frontend/services/customer_service.dart';

class MerchantShopScreen extends StatefulWidget {
  MerchantSearch merchant;

  MerchantShopScreen({
    super.key,
    required this.merchant,
  });

  @override
  State<MerchantShopScreen> createState() => _MerchantShopScreenState();
}

class _MerchantShopScreenState extends State<MerchantShopScreen> {
  Order? order;

  @override
  void initState() {
    super.initState();
    updateActiveOrders();
  }

  void updateActiveOrders() async {
    CustomerOrderService.getOrderByCustomerAndMerchantAndOrderStatus(
      context: context,
      merchantName: widget.merchant.username,
      orderStatus: "CREATED",
    ).then((value) => {
          setState(() {
            order = value;
          })
        });
    // print(_order!.toJson().toString());
  }

  Future updateCustomerMerchantOrder(int productId, int quantity) async {
    // 1. no existing orders yet

    if (order == null) {
      // create new order
      Order _order = Order.createOrder(
        isDineIn: false,
        orderItems: [
          OrderItem.createOrderItem(
            productId: productId,
            quantity: quantity,
          )
        ],
        orderStatus: "CREATED",
      );
      CustomerOrderService.createCustomerOrder(
        context: context,
        order: _order,
        merchantName: widget.merchant.username,
      ).then((value) => updateActiveOrders());
    } else if (order!.orderItems != null &&
        order!.orderItems!.where((e) => e.productId == productId).isEmpty) {
      // 2. existing order, add new order item
      int orderId = order!.id!;
      OrderItem orderItem = OrderItem.createOrderItem(
        productId: productId,
        quantity: quantity,
      );

      CustomerOrderService.createCustomerOrderItem(
        context: context,
        orderId: orderId,
        orderItem: orderItem,
        merchantName: widget.merchant.username,
      ).then((value) => updateActiveOrders());
    } else if (order!.orderItems != null &&
        order!.orderItems!.where((e) => e.productId == productId).isNotEmpty) {
      // 3. existing order, update order item
      Order _order = order!;
      OrderItem _orderItem = _order.orderItems!
          .where((element) => element.productId == productId)
          .first;
      _orderItem.quantity = quantity;
      CustomerOrderService.updateCustomerOrder(
        context: context,
        order: _order,
        merchantName: widget.merchant.username,
      ).then((value) => updateActiveOrders());
    }
    // refresh the data
  }

  // iterate through categories and create category lists
  buildMerchantShopMenuSection(List<Category>? categories) {
    List<Widget> categoryMenuList = [];
    if (categories != null && categories.isNotEmpty) {
      for (Category category in categories) {
        if (category.products != null && category.products!.isNotEmpty) {
          categoryMenuList.addAll(
            [
              MerchantShopMenuSection(
                title: category.name,
                merchantProductList: category.products!,
                order: order,
                updateCustomerMerchantOrder: updateCustomerMerchantOrder,
              ),
            ],
          );
        }
      }
    }
    return categoryMenuList;
  }

  void onViewCartPressed() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CartScreen()),
        (Route<dynamic> route) {
      return !route.hasActiveRouteBelow;
    });
  }

  @override
  Widget build(BuildContext context) {
    MerchantSearch merchant = widget.merchant;

    return Scaffold(
      bottomNavigationBar: order != null && order!.orderItems!.isNotEmpty
          ? MerchantShopBottomAppBar(
              onViewCartPressed: onViewCartPressed,
              itemCount: order!.orderItems!.fold(
                  0,
                  (previousValue, element) =>
                      previousValue + (element.quantity!)),
              itemTotalPrice: order!.totalPrice!,
            )
          : const SizedBox(
              height: 0,
            ),
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  merchant.company,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(merchant.bannerUrl),
              MerchantShopAboutSection(
                merchant: merchant,
              ),
              Divider(
                thickness: 5,
                color: Colors.grey.shade100,
              ),
              ...buildMerchantShopMenuSection(merchant.categories),
              Divider(
                thickness: 5,
                color: Colors.grey.shade100,
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
