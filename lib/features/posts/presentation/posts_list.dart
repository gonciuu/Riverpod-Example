import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../features/posts/presentation/posts_controller.dart';

import '../domain/post.dart';

class PostsList extends ConsumerWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsControllerProvider);

    return posts.when(data: (List<Post> posts) {
      return ListView.separated(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          final Post post = posts[index];
          return ListTile(
            title: Text(post.title,
                style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(post.body),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await ref
                    .read(postsControllerProvider.notifier)
                    .deletePost(post.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Post deleted'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Center(
        child: Text('Error: $error'),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    });
  }
}
