import 'package:fb_test2/models/post/post.model.dart';
import 'package:fb_test2/screens/posts/posts.detail.screen.dart';
import 'package:fb_test2/services/post/post.service.dart';
import 'package:fb_test2/states/post_state.dart';
import 'package:fb_test2/states/user_state.dart';
import 'package:fb_test2/widgets/post/post.list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsMyPosts extends StatefulWidget {
  const PostsMyPosts({super.key});

  @override
  State<PostsMyPosts> createState() => _PostsMyPostsState();
}

class _PostsMyPostsState extends State<PostsMyPosts> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadMyPosts());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMyPosts() async {
    final userId = UserState.of(context).user?.id;
    if (userId == null) return;
    PostState.of(context).startFetchingMyPosts();
    final result = await PostService.instance.getPosts(userId: userId);
    if (!mounted) return;
    PostState.of(context).setMyPosts(result.posts, result.total);
  }

  Future<void> _loadMoreMyPosts() async {
    final state = PostState.of(context);
    if (!state.hasMoreMyPosts || state.isLoading) return;
    final userId = UserState.of(context).user?.id;
    if (userId == null) return;
    final nextPage = state.myPostsPage + 1;
    state.startLoadingMoreMyPosts();
    final result = await PostService.instance.getPosts(
      userId: userId,
      page: nextPage,
    );
    if (!mounted) return;
    PostState.of(context).appendMyPosts(result.posts, result.total, nextPage);
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) _loadMoreMyPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PostState, (bool, List<PostModel>?, bool)>(
      selector: (_, s) => (s.isLoading, s.myPosts, s.hasMoreMyPosts),
      builder: (context, data, _) {
        final (isLoading, posts, _) = data;

        if (isLoading && posts == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (posts == null || posts.isEmpty) {
          return const Center(child: Text("No posts found"));
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: posts.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == posts.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final post = posts[index];
            return PostListItem(
              post: post,
              onTap: () {
                PostState.of(context).setSelectedPost(post);
                PostDetailScreen.push(context);
              },
            );
          },
        );
      },
    );
  }
}
