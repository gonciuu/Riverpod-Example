import 'package:medium_riverpod_sample/features/posts/domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/posts_repository.dart';

part 'posts_controller.g.dart';

@riverpod
class PostsController extends _$PostsController {
  @override
  FutureOr<List<Post>> build() async {
    return ref.read(postsRepositoryProvider).getPosts();
  }

  Future<Post> createPost(String title, String body, int userId) async {
    final Post post =
        await ref.read(postsRepositoryProvider).createPost(title, body, userId);
    ref.invalidateSelf();
    await future;
    return post;
  }

  Future<void> deletePost(int postId) async {
    await ref.read(postsRepositoryProvider).deletePost(postId);

    ref.invalidateSelf();
    await future;
  }
}
