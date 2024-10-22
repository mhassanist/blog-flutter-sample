import 'dart:convert';
import 'package:blog/errors/app_error.dart';
import 'package:http/http.dart' as http;
import 'package:blog/models/post.dart';

class PostApiService {
  final String baseUrl;
  final http.Client client;

  PostApiService({required this.baseUrl, required this.client});

  Future<List<Post>> getPosts(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/posts'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw const NotAuthorized();
    } else {
      throw const NetworkError();
    }
  }
}