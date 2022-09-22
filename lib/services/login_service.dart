import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_form.dart';
import '../providers/auth_provider.dart';

class LogInService {
  var httpClient = http.Client();

  Future userLogIn(LoginForm loginForm) async {
    //todo
    final response = await httpClient.post(
        Uri.parse('http://localhost:8001/auth/login'),
        body: json.encode(loginForm.toJson()),
        headers: {'content-type': 'application/json'});
    return response;
  }
}