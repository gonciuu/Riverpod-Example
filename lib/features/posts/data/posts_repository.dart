import 'package:dio/dio.dart';
import 'package:medium_riverpod_sample/core/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/post.dart';

part 'posts_repository.g.dart';

abstract class PostsRepositoryImpl {
  Future<List<Post>> getPosts();

  Future<Post> createPost(String title, String body, int userId);

  Future<void> deletePost(int postId);
}

@riverpod
PostsRepository postsRepository(PostsRepositoryRef ref) {
  return PostsRepository(
    client: ref.watch(dioProvider),
  );
}

class PostsRepository implements PostsRepositoryImpl {
  PostsRepository({required this.client});

  final Dio client;

  @override
  Future<List<Post>> getPosts() async {
    final Response<List<dynamic>> response = await client.get('/posts');
    return response.data?.map((e) => Post.fromJson(e)).toList() ?? [];
  }

  @override
  Future<Post> createPost(String title, String body, int userId) async {
    final Response<Map<String, dynamic>?> response =
        await client.post('/posts', data: <String, dynamic>{
      'title': title,
      'body': body,
      'userId': userId,
    });
    if (response.data != null) {
      return Post.fromJson(response.data!);
    }
    throw Exception('Failed to create post');
  }

  @override
  Future<void> deletePost(int postId) async {
    await client.delete('/posts/$postId');
  }
}
