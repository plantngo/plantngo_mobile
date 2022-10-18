import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _token = 'token';
  static String? authority;

  static void setToken(String token) async {
    await _storage.write(key: _token, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _token);
  }

  static void deleteAll() async {
    await _storage.deleteAll();
  }
}
