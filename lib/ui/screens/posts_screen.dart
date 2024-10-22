import 'package:blog/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog/cubits/posts_cubit.dart';
import 'package:blog/ui/screens/login_screen.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is PostsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            if (state.message == 'User not authenticated') {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is PostsInitial) {
            context.read<PostsCubit>().loadPosts();
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoaded) {
            return _buildPostList(state.posts);
          } else if (state is PostsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPostList(List<Post> posts) {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Implement refresh functionality
      },
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
            onTap: () {
              // TODO: Navigate to post details screen
            },
          );
        },
      ),
    );
  }
}