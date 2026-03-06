import 'package:fb_test2/models/post/post.model.dart';
import 'package:fb_test2/utils/api/api.util.dart';

class PostRepository {
  PostRepository._();

  static final _instance = PostRepository._();
  static PostRepository get instance => _instance;

  Future<({List<PostModel> posts, int total})> getPosts({
    int page = 1,
    int limit = 10,
    String? userId,
  }) async {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'user_id': userId,
    };
    final response = await ApiUtil.instance.get('/posts', params: params);
    final List posts = response.data['posts'];
    final pagination = response.data['pagination'];
    return (
      posts: posts.map((p) => PostModel.fromJson(p)).toList(),
      total: pagination['total'] as int,
    );
  }

  Future<PostModel> getPost(String id) async {
    final response = await ApiUtil.instance.get('/posts/$id');
    return PostModel.fromJson(response.data['post']);
  }

  Future<PostModel> updatePost(PostModel model) async {
    final response = await ApiUtil.instance.put('/posts/${model.id}', data: {
      'user_id': model.userId,
      'title': model.title,
      'body': model.body,
    });
    return PostModel.fromJson(response.data['post']);
  }

  Future<void> deletePost(PostModel model) async {
    await ApiUtil.instance.delete('/posts/${model.id}', data: {
      'user_id': model.userId,
    });
  }

  Future<PostModel> createPost(PostModel model) async {
    final response = await ApiUtil.instance.post('/posts', data: {
      'user_id': model.userId,
      'title': model.title,
      'body': model.body,
    });
    return PostModel.fromJson(response.data['post']);
  }
}
