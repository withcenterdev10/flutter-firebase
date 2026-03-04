import 'package:fb_test2/widgets/user/posts/user.posts.dart';
import 'package:fb_test2/widgets/user/user_ready.dart';
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
      appBar: AppBar(title: Text("User posts")),
      body: Center(
        child: UserReady(
          yes: () {
            return UserPosts(
              builder: (context, posts) {
                if (posts.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        ...posts.map((post) {
                          return Text("Title: ${post['title']}");
                        }),
                      ],
                    ),
                  );
                } else {
                  return Text("No posts found :<");
                }
              },
            );
          },
        ),
      ),
    );
  }
}
