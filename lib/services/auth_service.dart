import 'dart:async';
import 'dart:math';
import 'package:blog/errors/app_error.dart';
import 'package:blog/models/user.dart';

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
}

class AuthService {
  Future<User> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    //random success or failure
    final random = Random();
    if (random.nextBool()) {
      throw const NotAuthorized();
    } else{
      return const User(id: 100, name: "name", email: "email", token: "token");
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
