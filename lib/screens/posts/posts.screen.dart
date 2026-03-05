import 'package:fb_test2/widgets/user/posts/user_posts.dart';
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
    print("Rebuilding posts screen");
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Add random post"),
                        ),

                        ...posts.map((post) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Title: ${post['title']}"),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("No posts found :<"),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Add random post"),
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
