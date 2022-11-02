import 'package:flutter/material.dart';

import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  Order? _order = null;

  Order? get order => _order;
}
