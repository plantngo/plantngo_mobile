import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/providers/location_provider.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_search/merchant_search_result_card.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_search/merchant_search_suggestion_tile.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_details_screen.dart';
import 'package:plantngo_frontend/services/location_service.dart';
import 'package:plantngo_frontend/services/merchant_search_service.dart';
import 'package:plantngo_frontend/utils/mock_merchants.dart';
import 'package:provider/provider.dart';

class MerchantSearchDelegate extends SearchDelegate {
  MerchantSearchDelegate({
    required String searchFieldPlaceholder,
  }) : super(
          searchFieldLabel: searchFieldPlaceholder,
          searchFieldStyle: const TextStyle(
            fontSize: 14,
          ),
          // searchFieldDecorationTheme: const InputDecorationTheme(),
        );

  final MerchantSearchService merchantSearchService = MerchantSearchService();

  late Future<List<MerchantSearch>> futureMerchantSearchList;

  Future<List<MerchantSearch>> searchMerchants(
      BuildContext context, String query) {
    return merchantSearchService.searchAllMerchants(context, query);
  }

  resetSearchField(BuildContext context) async {
    query = '';
    futureMerchantSearchList = searchMerchants(context, query);
    showSuggestions(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(
            Icons.clear,
          ),
          onPressed: () {
            resetSearchField(context);
          },
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          if (query != '') {
            resetSearchField(context);
          } else {
            close(context, null);
          }
        },
      );

  @override
  Widget buildResults(BuildContext context) {
    futureMerchantSearchList = searchMerchants(context, query);

    return WillPopScope(
      onWillPop: () async {
        // if there is a query, it shouldnt pop
        bool shouldPop = query == '';
        if (!shouldPop) {
          resetSearchField(context);
        }
        return shouldPop;
      },
      child: FutureBuilder<List<MerchantSearch>>(
        future: futureMerchantSearchList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Failed to load page"),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final result = snapshot.data![index];
                return MerchantSearchResultCard(
                  merchant: result,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MerchantShopDetailsScreen(
                          merchant: result,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Results"),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    futureMerchantSearchList = searchMerchants(context, query);

    return WillPopScope(
      onWillPop: () async {
        // if there is a query, it shouldnt pop
        bool shouldPop = query == '';
        if (!shouldPop) {
          resetSearchField(context);
        }
        return shouldPop;
      },
      child: FutureBuilder<List<MerchantSearch>>(
        future: futureMerchantSearchList,
        builder: (context, snapshot) {
          print(snapshot!);
          if (snapshot.hasError) {
            return const Center(
              child: Text("Failed to load page"),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final suggestion = snapshot.data![index];
                return MerchantSearchSuggestionTile(
                  merchant: suggestion,
                  onTap: () {
                    // -- Does another search
                    // query = suggestion.company;
                    // // shows the results of the search
                    // showResults(context);

                    // -- Show result page immediately
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MerchantShopDetailsScreen(
                          merchant: suggestion,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Results"),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
