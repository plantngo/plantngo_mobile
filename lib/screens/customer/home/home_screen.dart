import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_search/merchant_search_delegate.dart';
import 'package:plantngo_frontend/services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  fetchLocation() async {
    Future<dynamic> position = determinePosition();
  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    const String searchFieldPlaceholder = "Search for food and shops";
    const double bannerHeight = 200.0;

    List<String> nearbyBanners = [
      'https://placeimg.com/640/480/any',
      'https://placeimg.com/640/480/any',
      'https://placeimg.com/640/480/any',
    ];
    List<String> promotionBanners = [
      'https://placeimg.com/640/480/any',
      'https://placeimg.com/640/480/any',
      'https://placeimg.com/640/480/any',
    ];
    List<String> trendingBanners = [
      'https://placeimg.com/640/480/any',
      'https://placeimg.com/640/480/any',
      'https://placeimg.com/640/480/any',
    ];

    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            // backgroundColor: Theme.of(context).primaryColor,
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
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
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
                      Text(
                        "Nearby",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: bannerHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: nearbyBanners.length,
                          itemBuilder: (_, i) {
                            return Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                nearbyBanners[i],
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(10),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Promotions",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: bannerHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: promotionBanners.length,
                          itemBuilder: (context, index) {
                            return Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                promotionBanners[index],
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(10),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Trending",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: bannerHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trendingBanners.length,
                          itemBuilder: (context, index) {
                            return Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                trendingBanners[index],
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(10),
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
