import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/models/product.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_about_section.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_menu_section.dart';
import 'package:plantngo_frontend/utils/mock_merchants.dart';
import 'package:plantngo_frontend/utils/mock_products.dart';

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
  // late Future<MerchantSearch> futureMerchant;
  // late Future<List<Product>> futurePopularProduct;
  // late Future<List<Product>> futureMenuProduct;

  // Future<MerchantSearch> fetchMerchantData() {
  //   return Future<MerchantSearch>.value(
  //       mockMerchantSearchList.firstWhere((e) => e.id == widget.merchantId));
  // }

  // Future<List<Product>> fetchMerchantPopularProductData() {
  //   return Future<List<Product>>.value(mockProductList);
  // }

  // Future<List<Product>> fetchMerchantMenuProductData() {
  //   return Future<List<Product>>.value(mockProductList);
  // }

  @override
  void initState() {
    super.initState();
    // futureMerchant = fetchMerchantData();
    // futurePopularProduct = fetchMerchantPopularProductData();
    // futureMenuProduct = fetchMerchantMenuProductData();
  }

  buildMenu(List<Category>? categories) {
    List<Widget> categoryMenuList = [];
    if (categories != null && categories.isNotEmpty) {
      for (Category category in categories) {
        if (category.products != null && category.products!.isNotEmpty) {
          categoryMenuList.addAll(
            [
              MerchantShopMenuSection(
                  title: category.name,
                  merchantProductList: category.products!),
              const Divider(
                thickness: 5,
              ),
            ],
          );
        }
      }
    }
    return categoryMenuList;
  }

  @override
  Widget build(BuildContext context) {
    MerchantSearch merchant = widget.merchant;

    return Scaffold(
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
              const Divider(
                thickness: 5,
              ),
              ...buildMenu(merchant.categories),
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
