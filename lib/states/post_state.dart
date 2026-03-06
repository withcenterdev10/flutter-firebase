import 'package:fb_test2/models/post/post.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostState extends ChangeNotifier {
  bool isLoading = false;

  List<PostModel>? posts;
  bool hasMorePosts = true;
  int _postsPage = 1;
  int get postsPage => _postsPage;

  // Selected post (detail / edit screen)
  PostModel? selectedPost;

  static PostState of(BuildContext context) => context.read<PostState>();

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void startFetchingPosts() {
    _postsPage = 1;
    hasMorePosts = true;
    posts = null;
    _setLoading(true);
  }

  void setPosts(List<PostModel> newPosts, int total) {
    posts = newPosts;
    hasMorePosts = newPosts.length < total;
    _setLoading(false);
  }

  void startLoadingMorePosts() => _setLoading(true);

  void appendPosts(List<PostModel> morePosts, int total, int page) {
    _postsPage = page;
    posts = [...?posts, ...morePosts];
    hasMorePosts = posts!.length < total;
    _setLoading(false);
  }

  // Selected post
  void setSelectedPost(PostModel post) {
    selectedPost = post;
    notifyListeners();
  }

  void startSubmitting() => _setLoading(true);

  void updateSelectedPost(PostModel updated) {
    selectedPost = updated;
    posts = posts?.map((p) => p.id == updated.id ? updated : p).toList();
    _setLoading(false);
  }

  void removePost(String postId) {
    posts = posts?.where((p) => p.id != postId).toList();
    selectedPost = null;
    _setLoading(false);
  }

  // Create
  void createPost(PostModel post) {
    posts = [post, ...?posts];
    notifyListeners();
  }
}
