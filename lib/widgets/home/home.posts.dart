import 'package:fb_test2/models/post/post.model.dart';
import 'package:fb_test2/screens/posts/posts.detail.screen.dart';
import 'package:fb_test2/services/post/post.service.dart';
import 'package:fb_test2/states/post_state.dart';
import 'package:fb_test2/widgets/post/post.list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePosts extends StatefulWidget {
  const HomePosts({super.key});

  @override
  State<HomePosts> createState() => _HomePostsState();
}

class _HomePostsState extends State<HomePosts> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPosts());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    PostState.of(context).startFetchingPosts();
    final result = await PostService.instance.getPosts();
    if (!mounted) return;
    PostState.of(context).setPosts(result.posts, result.total);
  }

  Future<void> _loadMorePosts() async {
    final state = PostState.of(context);
    if (!state.hasMorePosts || state.isLoading) return;
    final nextPage = state.postsPage + 1;
    state.startLoadingMorePosts();
    final result = await PostService.instance.getPosts(page: nextPage);
    if (!mounted) return;
    PostState.of(context).appendPosts(result.posts, result.total, nextPage);
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) _loadMorePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PostState, (bool, List<PostModel>?, bool)>(
      selector: (_, s) => (s.isLoading, s.posts, s.hasMorePosts),
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
