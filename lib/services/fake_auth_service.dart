import 'dart:async';

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
}

class FakeAuthService {
  Future<String> login(String email, String password) async {

    //post request to server 
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@example.com' && password == 'password123') {
      return 'fake_jwt_token';
    } else {
      throw AuthenticationException('Invalid email or password');
    }
  }

  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> isLoggedIn() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return false;
  }

  //forget password
  Future<void> forgotPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }

}
