import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/posts/presentation/add_post_form.dart';
import 'features/posts/presentation/posts_list.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod demo"),
      ),
      body: const PostsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         showModalBottomSheet(context: context, builder: (BuildContext context) {
           return const AddPostForm();
         });
        },
        child: const Icon(Icons.add),
      )
    );
  }
}
