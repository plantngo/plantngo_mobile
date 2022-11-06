import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/quest_progress.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/utils/global_variables.dart';
import 'package:plantngo_frontend/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QuestService {
  static Future<List<QuestProgress>> getActiveQuestsByUser({
    required BuildContext context,
  }) async {
    List<QuestProgress> questProgress = [];
    try {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      String? token = await UserSecureStorage.getToken();
      http.Response res = await http.get(
        Uri.parse(
            '$uri/api/v1/quests/active/progress/user/${customerProvider.customer.username}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      jsonDecode(res.body)
          .map((e) => questProgress.add(QuestProgress.fromJson(e)))
          .toList();
      print(questProgress.toString());
    } catch (e) {
      //todo
    }
    return questProgress;
  }
}
