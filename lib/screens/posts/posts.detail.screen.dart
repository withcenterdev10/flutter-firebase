import 'package:fb_test2/models/post/post.model.dart';
import 'package:fb_test2/screens/posts/posts.edit.screen.dart';
import 'package:fb_test2/services/post/post.service.dart';
import 'package:fb_test2/states/post_state.dart';
import 'package:fb_test2/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});

  static const String routeName = '/post-detail';
  static void push(BuildContext context) => context.push(routeName);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  Future<void> _handleDelete(PostModel post) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete this post?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final userId = UserState.of(context).user!.id!;
    PostState.of(context).startSubmitting();
    await PostService.instance.deletePost(postId: post.id!, userId: userId);
    if (!mounted) return;
    PostState.of(context).removePost(post.id!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post deleted")),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PostState, (PostModel?, bool)>(
      selector: (_, s) => (s.selectedPost, s.isLoading),
      builder: (context, data, _) {
        final (post, isLoading) = data;

        if (post == null) return const Scaffold(body: SizedBox.shrink());

        final currentUserId = context.read<UserState>().user?.id;
        final isOwner = currentUserId != null && currentUserId == post.userId;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Post"),
            actions: isOwner
                ? [
                    IconButton(
                      onPressed:
                          isLoading ? null : () => EditPostScreen.push(context),
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed:
                          isLoading ? null : () => _handleDelete(post),
                      icon: const Icon(Icons.delete),
                    ),
                  ]
                : null,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title ?? '',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  post.createdAt ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                Text(post.body ?? ''),
              ],
            ),
          ),
        );
      },
    );
  }
}
