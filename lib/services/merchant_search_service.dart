import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/merchant_search.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/location_provider.dart';
import 'package:plantngo_frontend/utils/global_variables.dart';
import 'package:plantngo_frontend/utils/user_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MerchantSearchService {
  Future<List<MerchantSearch>> searchAllMerchants(
      BuildContext context, String query) async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    List<MerchantSearch> merchant = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/merchant/search'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          MerchantSearch e = MerchantSearch.fromJson(jsonDecode(res.body)[i]);

          if (e.company.toLowerCase().trim().contains(query.toLowerCase()) ||
              e.cuisineType
                  .toLowerCase()
                  .trim()
                  .contains(query.toLowerCase())) {
            e.distanceFrom = locationProvider.calculateDistance(
              e.latitude,
              e.longitude,
            );
            merchant.add(e);
          }
        }
        merchant.sort(((a, b) {
          return a.distanceFrom!.compareTo(b.distanceFrom!);
        }));
      }
    } catch (e) {
      print(e.toString());
    }

    return merchant;
  }

  Future<MerchantSearch?> searchMerchantByUsername(
      BuildContext context, String username) async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String? token = await UserSecureStorage.getToken();

    MerchantSearch? merchantSearch;

    http.Response res = await http.get(
      Uri.parse('$uri/api/v1/merchant/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    merchantSearch = MerchantSearch.fromJson(jsonDecode(res.body));

    return merchantSearch;
  }
}
