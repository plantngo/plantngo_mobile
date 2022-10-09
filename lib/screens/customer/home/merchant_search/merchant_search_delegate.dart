import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_search/merchant_search_result_card.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_search/merchant_search_suggestion_tile.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_details_screen.dart';
import 'package:plantngo_frontend/services/location_service.dart';
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

  List<MerchantSearch> cachedSearchResults = [];

  List<MerchantSearch> fetchSearchResults(String query) {
    // fetch data and filter data TODO: Should be done with API call
    List<MerchantSearch> _data = mockMerchantSearchList;
    List<MerchantSearch> _searchResults = _data.where(
      (searchResult) {
        final result = searchResult.company.toLowerCase();
        final input = query.toLowerCase();
        return result.contains(input);
      },
    ).toList();
    return _searchResults;
  }

  void resetSearchField(BuildContext context) {
    query = '';
    cachedSearchResults = fetchSearchResults(query);
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
    cachedSearchResults = fetchSearchResults(query);

    return WillPopScope(
      onWillPop: () async {
        // if there is a query, it shouldnt pop
        bool shouldPop = query == '';
        if (!shouldPop) {
          resetSearchField(context);
        }
        return shouldPop;
      },
      child: ListView.builder(
        itemCount: cachedSearchResults.length,
        itemBuilder: (context, index) {
          final result = cachedSearchResults[index];
          return MerchantSearchResultCard(
            merchantImage: result.image,
            merchantName: result.company,
            merchantDistance: calculateDistance(
              result.lat,
              result.long,
              0,
              0,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MerchantShopDetailsScreen(
                  merchantId: result.id,
                  merchantName: result.company,
                  merchantDistance: calculateDistance(
                    result.lat,
                    result.long,
                    0,
                    0,
                  ),
                  merchantImage: result.image,
                ),
              ));
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    cachedSearchResults = fetchSearchResults(query);

    return WillPopScope(
      onWillPop: () async {
        // if there is a query, it shouldnt pop
        bool shouldPop = query == '';
        if (!shouldPop) {
          resetSearchField(context);
        }
        return shouldPop;
      },
      child: ListView.builder(
        itemCount: cachedSearchResults.length,
        itemBuilder: (context, index) {
          final suggestion = cachedSearchResults[index];
          return MerchantSearchSuggestionTile(
            merchantImage: suggestion.image,
            merchantName: suggestion.company,
            merchantDistance: calculateDistance(
              suggestion.lat,
              suggestion.long,
              0,
              0,
            ),
            onTap: () {
              query = suggestion.company;

              // shows the results of the search
              showResults(context);
            },
          );
        },
      ),
    );
  }
}
