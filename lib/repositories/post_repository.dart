import 'package:blog/models/post.dart';
import 'package:blog/services/post_api_service.dart';
import 'package:blog/repositories/auth_repository.dart';

class PostRepository {
  final PostApiService _apiService;
  final AuthRepository _authRepository;

  PostRepository({
    required PostApiService apiService,
    required AuthRepository authRepository,
  })  : _apiService = apiService,
        _authRepository = authRepository;

  Future<List<Post>> getPosts() async {
    final token = await _authRepository.getToken();
    if (token == null) {
      throw Exception('User not authenticated');
    }
    return _apiService.getPosts(token);
  }
}