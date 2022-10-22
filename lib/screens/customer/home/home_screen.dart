import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/promotion.dart';
import 'package:plantngo_frontend/providers/location_provider.dart';
import 'package:plantngo_frontend/providers/promotion_provider.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_promotion/merchant_promotion_details_screen.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_search/merchant_search_delegate.dart';
import 'package:plantngo_frontend/utils/mock_promotions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false)
        .determinePosition()
        .then(
          (value) => {
            Provider.of<LocationProvider>(context, listen: false)
                .setPosition(value),
          },
        );
    Provider.of<PromotionProvider>(context, listen: false)
        .setPromotions(context);
  }

  void onBannerPressed(String merchantName, String merchantPromotionImage) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MerchantPromotionDetailsScreen(
          merchantName: merchantName,
          merchantPromotionImage: merchantPromotionImage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var promotionProvider =
        Provider.of<PromotionProvider>(context, listen: true);
    const String searchFieldPlaceholder = "Search for food and shops";
    const double bannerHeight = 200.0;
    List<Promotion> promotion = promotionProvider.promotions;
    // replace with actual data
    List<String> nearbyBanners = mockNearbyBanners;
    List<String> promotionBanners = mockPromotionBanners;
    List<String> trendingBanners = mockTrendingBanners;

    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade200,
                      Colors.green.shade300,
                      Colors.green,
                    ],
                  ),
                ),
              ),
              title: FractionallySizedBox(
                widthFactor: 0.90,
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[800],
                    ),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.grey[800],
                    ),
                    hintText: searchFieldPlaceholder,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: MerchantSearchDelegate(
                        searchFieldPlaceholder: searchFieldPlaceholder,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left:8.0),
                        child: Text(
                          "Nearby",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: bannerHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: promotion.length,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {
                                onBannerPressed(
                                    "Promotion", promotion[i].bannerUrl!);
                              },
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                margin: const EdgeInsets.all(10),
                                child: Image.network(
                                  promotion[i].bannerUrl!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Promotions",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: bannerHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: promotionBanners.length,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {
                                onBannerPressed(
                                    "Promotion", promotionBanners[i]);
                              },
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                margin: const EdgeInsets.all(10),
                                child: Image.network(
                                  promotionBanners[i],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left:8.0),
                        child: Text(
                          "Trending",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: bannerHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trendingBanners.length,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {
                                onBannerPressed(
                                    "Promotion", trendingBanners[i]);
                              },
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                margin: const EdgeInsets.all(10),
                                child: Image.network(
                                  trendingBanners[i],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
