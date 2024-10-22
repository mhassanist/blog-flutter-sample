import 'package:blog/errors/app_error.dart';
import 'package:blog/errors/error_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:blog/models/post.dart';
import 'package:blog/repositories/post_repository.dart';

class PostsCubit extends Cubit<PostsState> {
  //TODO: Inject PostRepository using get_it

  final PostRepository _postRepository;

  PostsCubit({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostsInitial());

  Future<void> loadPosts() async {
    emit(PostsLoading());
    try {
      final posts = await _postRepository.getPosts();

      emit(PostsLoaded(posts));
    } on AppError catch (e) {
      emit(PostsError(e));
    } catch (e, stackTrace) {
      // Log unexpected errors or send them to a monitoring service
      if (kDebugMode) {
        print('Unexpected error: $e');
        print(stackTrace);
      }

      rethrow;
    }
  }
}

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  const PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {
  final AppError error;

  const PostsError(this.error);

  @override
  List<Object> get props => [error];
}
