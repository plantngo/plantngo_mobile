import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/providers/location_provider.dart';
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

  List<MerchantSearch> fetchSearchResults(String query, BuildContext context) {
    // fetch data and filter data TODO: Should be done with API call
    List<MerchantSearch> _data = mockMerchantSearchList;
    List<MerchantSearch> _searchResults = _data.where(
      (searchResult) {
        final result = searchResult.company.toLowerCase();
        final input = query.toLowerCase();
        return result.contains(input);
      },
    ).toList();
    for (MerchantSearch e in _searchResults) {
      e.distanceFrom = Provider.of<LocationProvider>(context).calculateDistance(
        e.lat,
        e.long,
      );
    }
    _searchResults.sort(((a, b) {
      return a.distanceFrom!.compareTo(b.distanceFrom!);
    }));
    return _searchResults;
  }

  void resetSearchField(BuildContext context) {
    query = '';
    cachedSearchResults = fetchSearchResults(query, context);
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
    cachedSearchResults = fetchSearchResults(query, context);

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
            merchantImage: result.logoUrl,
            merchantName: result.company,
            merchantDistance: result.distanceFrom,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MerchantShopDetailsScreen(
                    merchantId: result.id,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    cachedSearchResults = fetchSearchResults(query, context);

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
                    merchantId: suggestion.id,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
