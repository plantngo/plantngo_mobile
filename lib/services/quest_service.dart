import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plantngo_frontend/models/quest_progress.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/utils/global_variables.dart';
import 'package:plantngo_frontend/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QuestService {
  static Future<List<QuestProgress>> getActiveQuestsByUser({
    required BuildContext context,
    required String? username,
  }) async {
    List<QuestProgress> questProgress = [];

    try {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();
      if (username == null && customerProvider.customer.username == null) {
        return [];
      }
      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/v1/quests/active/progress/user/${username ?? customerProvider.customer.username!}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      print(jsonDecode(res.body).toString());
      if (res.statusCode == 200) {
        print(jsonDecode(res.body).toString());
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          // print(Promotion.fromJSON(jsonDecode(res.body)[i]));
          questProgress.add(QuestProgress.fromJson(jsonDecode(res.body)[i]));
        }
      }
      // print(promotions);
      // }
      // jsonDecode(res.body)
      //     .map((e) => questProgress.add(QuestProgress.fromJson(e)))
      //     .toList();
    } catch (e) {
      //todo
      print(e);
    }
    return questProgress;
  }

  static Future<Response?> refreshQuestByQuestIdAndUser({
    required BuildContext context,
    required int id,
  }) async {
    Future<Response?> res;
    try {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();
      res = http.post(
        Uri.parse(
            '$uri/api/v1/quests/$id/refresh/${customerProvider.customer.username}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      return res;
    } catch (e) {
      //todo
    }
  }
}
