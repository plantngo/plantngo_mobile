import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/promotion.dart';
import 'package:plantngo_frontend/models/quest_progress.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/location_provider.dart';
import 'package:plantngo_frontend/providers/promotion_provider.dart';
import 'package:plantngo_frontend/screens/customer/cart/cart_main_screen.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_promotion/merchant_promotion_details_screen.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_search/merchant_search_delegate.dart';
import 'package:plantngo_frontend/screens/customer/home/quests/quest_section.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/promotion_service.dart';
import 'package:plantngo_frontend/services/quest_service.dart';
import 'package:plantngo_frontend/utils/mock_promotions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<QuestProgress>> questProgress = Future.delayed(
    Duration(seconds: 10),
    () {
      return [];
    },
  );
  late List<Promotion> promotion = [];
  late List<Promotion> trending = [];

  @override
  void initState() {
    AuthService.getUserData(context).then(
      (value) {
        retrieveQuests(value);
      },
    );
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
        .setPromotions(context)
        .then((value) => retrievePromotions());
  }

  void onBannerPressed(Promotion promotion) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MerchantPromotionDetailsScreen(
          promotion: promotion,
        ),
      ),
    );
  }

  void retrieveQuests(String? username) {
    setState(() {
      questProgress = QuestService.getActiveQuestsByUser(
          context: context, username: username);
    });
  }

  void retrievePromotions() {
    Provider.of<PromotionProvider>(context, listen: false)
        .setPromotions(context)
        .then((value) {
      List<Promotion> _promotion = value;
      List<Promotion> _trending = [];

      for (var i = 0; i < value.length / 2; i++) {
        _trending.add(value[i]);
      }

      for (Promotion promo in _trending) {
        _promotion.remove(promo);
      }

      setState(() {
        promotion = _promotion;
        trending = _trending;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const String searchFieldPlaceholder = "Search for food and shops";
    const double bannerHeight = 200.0;

    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(
          Duration(seconds: 1),
          () {
            retrieveQuests(Provider.of<CustomerProvider>(context, listen: false)
                .customer
                .username);
            AuthService.getUserData(context);
            retrievePromotions();
            Provider.of<LocationProvider>(context, listen: false)
                .determinePosition()
                .then(
                  (value) => {
                    Provider.of<LocationProvider>(context, listen: false)
                        .setPosition(value),
                  },
                );
          },
        );
      },
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: const CircleBorder(),
              // Lead to checkout page
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CartMainScreen()),
                );
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              floating: true,
              expandedHeight: 100,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                centerTitle: true,
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
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Quests",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        QuestSection(
                          questProgress: questProgress,
                          refreshQuestProgressHook: retrieveQuests,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Trending",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(
                          height: bannerHeight,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: trending.length,
                            itemBuilder: (_, i) {
                              return GestureDetector(
                                onTap: () {
                                  onBannerPressed(trending[i]);
                                  PromotionService.addClicks(
                                      context: context,
                                      promotionId: trending[i].id!);
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
                                    trending[i].bannerUrl!,
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
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Promotions",
                            style: Theme.of(context).textTheme.titleMedium,
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
                                  onBannerPressed(promotion[i]);
                                  PromotionService.addClicks(
                                      context: context,
                                      promotionId: promotion[i].id!);
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
