import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/utils/global_variables.dart';
import 'package:plantngo_frontend/utils/user_secure_storage.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  Order? _order;

  Order? get order => _order;

  void updateAllACtiveOrders() {}
}
