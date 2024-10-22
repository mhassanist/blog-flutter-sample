import 'package:blog/models/post.dart';
import 'package:blog/services/post_api_service.dart';

class PostRepository {
  final PostApiService _apiService;

  PostRepository({
    required PostApiService apiService,
  })  : _apiService = apiService;

  Future<List<Post>> getPosts() async {
    return _apiService.getPosts("token");
  }
}