import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final FlutterSecureStorage _secureStorage;

  AuthRepository({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

 Future<void> login(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}