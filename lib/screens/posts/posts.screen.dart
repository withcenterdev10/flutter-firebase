import 'package:fb_test2/widgets/posts/posts.my_posts.dart';
import 'package:fb_test2/widgets/user/user.ready.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  static const String routeName = '/posts';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) => context.go(routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Posts")),
      body: UserReady(
        yes: () => const PostsMyPosts(),
        no: () => const Center(child: Text("Please sign in to see your posts")),
      ),
    );
  }
}
