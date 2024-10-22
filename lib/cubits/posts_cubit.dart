import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:blog/models/post.dart';
import 'package:blog/repositories/post_repository.dart';


class PostsCubit extends Cubit<PostsState> {
  final PostRepository _postRepository;

  PostsCubit({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostsInitial());

  Future<void> loadPosts() async {
    emit(PostsLoading());
    try {
      final posts = await _postRepository.getPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
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
  final String message;

  const PostsError(this.message);

  @override
  List<Object> get props => [message];
}