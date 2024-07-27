import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medium_riverpod_sample/features/posts/presentation/posts_controller.dart';

class AddPostForm extends HookConsumerWidget {
  const AddPostForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final bodyController = useTextEditingController();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(labelText: 'Body'),
            controller: bodyController,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              await ref.read(postsControllerProvider.notifier).createPost(
                  titleController.text,
                  bodyController.text,
                  //fake userId
                  1);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post added')),
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add post'),
          ),
        ],
      ),
    );
  }
}
