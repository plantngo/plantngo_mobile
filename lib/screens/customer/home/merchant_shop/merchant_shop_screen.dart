import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_about_section.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_bottom_app_bar.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_menu_section.dart';
import 'package:plantngo_frontend/services/customer_order_service.dart';

class MerchantShopDetailsScreen extends StatefulWidget {
  MerchantSearch merchant;

  MerchantShopDetailsScreen({
    super.key,
    required this.merchant,
  });

  @override
  State<MerchantShopDetailsScreen> createState() =>
      _MerchantShopDetailsScreenState();
}

class _MerchantShopDetailsScreenState extends State<MerchantShopDetailsScreen> {
  Order? customerMerchantOrder;

  @override
  void initState() {
    super.initState();
    updateActiveOrders();
  }

  updateActiveOrders() async {
    CustomerOrderService.getOrderByCustomerAndMerchantAndOrderStatus(
      context: context,
      merchantName: widget.merchant.username,
      orderStatus: "CREATED",
    ).then((value) {
      SchedulerBinding.instance.addPostFrameCallback((d) {
        setState(() {
          customerMerchantOrder = value;
        });
      });
    });
  }

  updateCustomerMerchantOrder(Order order) {
    setState(() {
      customerMerchantOrder = order;
    });
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
                customerMerchantOrder: customerMerchantOrder,
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
      bottomNavigationBar: customerMerchantOrder != null &&
              customerMerchantOrder!.orderItems!.isNotEmpty
          ? MerchantShopBottomAppBar(
              onViewCartPressed: onViewCartPressed,
              itemCount: customerMerchantOrder!.orderItems!.length,
              itemTotalPrice: customerMerchantOrder!.totalPrice!,
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
