import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blog/services/post_api_service.dart';
import 'package:blog/repositories/auth_repository.dart';
import 'package:blog/repositories/post_repository.dart';
import 'package:blog/cubits/login_cubit.dart';
import 'package:blog/cubits/posts_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Services
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => PostApiService(baseUrl: 'https://jsonplaceholder.typicode.com', client: getIt()));

  // Repositories
  getIt.registerLazySingleton(() => AuthRepository(secureStorage: getIt()));
  getIt.registerLazySingleton(() => PostRepository(apiService: getIt()));

  // Cubits
  getIt.registerFactory(() => LoginCubit(authRepository: getIt()));
  getIt.registerFactory(() => PostsCubit(postRepository: getIt()));
}