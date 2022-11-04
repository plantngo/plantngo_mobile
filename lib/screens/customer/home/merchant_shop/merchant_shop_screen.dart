import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/orderitem.dart';
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

  Future updateActiveOrders() async {
    Order? _order =
        await CustomerOrderService.getOrderByCustomerAndMerchantAndOrderStatus(
      context: context,
      merchantName: widget.merchant.username,
      orderStatus: "CREATED",
    );
    setState(() {
      order = _order;
    });
  }

  Future updateCustomerMerchantOrder(int productId, int quantity) async {
    // no existing orders yet
    if (order == null) {
      // create new order
      Order order = Order.createOrder(
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
        order: order,
        merchantName: widget.merchant.username,
      ).then((value) => updateActiveOrders());
    } else {
      // update existing order

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

  void onViewCartPressed() {}

  @override
  Widget build(BuildContext context) {
    MerchantSearch merchant = widget.merchant;

    return Scaffold(
      bottomNavigationBar: order != null && order!.orderItems!.isNotEmpty
          ? MerchantShopBottomAppBar(
              onViewCartPressed: onViewCartPressed,
              itemCount: order!.orderItems!.length,
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
