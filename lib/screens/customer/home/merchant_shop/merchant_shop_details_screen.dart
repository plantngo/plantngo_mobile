import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/merchant.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_about_section.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_menu_section.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_popular_section.dart';
import 'package:plantngo_frontend/utils/mock_merchants.dart';

class MerchantShopDetailsScreen extends StatefulWidget {
  int merchantId;

  MerchantShopDetailsScreen({
    super.key,
    required this.merchantId,
  });

  @override
  State<MerchantShopDetailsScreen> createState() =>
      _MerchantShopDetailsScreenState();
}

class _MerchantShopDetailsScreenState extends State<MerchantShopDetailsScreen> {
  late Future<MerchantSearch> futureMerchant;

  Future<MerchantSearch> fetchMerchantData() {
    return Future<MerchantSearch>.value(
        mockMerchantSearchList.firstWhere((e) => e.id == widget.merchantId));
  }

  @override
  void initState() {
    super.initState();
    futureMerchant = fetchMerchantData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MerchantSearch>(
      future: futureMerchant,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Failed to load page"),
          );
        } else if (snapshot.hasData) {
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
                        snapshot.data!.company,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ];
              },
              body: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MerchantShopAboutSection(
                    merchantAddress: snapshot.data!.address,
                  ),
                  const Divider(
                    thickness: 5,
                  ),
                  MerchantShopPopularSection(),
                  const Divider(
                    thickness: 5,
                  ),
                  MerchantShopMenuSection(),
                ],
              ),
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
