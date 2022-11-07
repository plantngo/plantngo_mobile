import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)["message"]);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)["message"]);
      break;
    default:
      showSnackBar(context, jsonDecode(response.body)["message"]);
  }
}
