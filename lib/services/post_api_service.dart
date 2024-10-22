import 'dart:convert';
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
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load posts');
    }
  }
}