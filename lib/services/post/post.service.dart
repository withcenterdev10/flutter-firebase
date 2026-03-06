import 'package:fb_test2/models/post/post.model.dart';
import 'package:fb_test2/repositories/post/post.repository.dart';

class PostService {
  PostService._();

  static final _instance = PostService._();
  static PostService get instance => _instance;

  final PostRepository _repository = PostRepository.instance;

  Future<({List<PostModel> posts, int total})> getPosts({
    String? userId,
    int page = 1,
    int limit = 10,
  }) async {
    return await _repository.getPosts(page: page, limit: limit, userId: userId);
  }

  Future<PostModel> getPost(String id) async {
    return await _repository.getPost(id);
  }

  Future<PostModel> updatePost({
    required String postId,
    required String userId,
    required String title,
    required String body,
  }) async {
    final model = PostModel(id: postId, userId: userId, title: title, body: body);
    return await _repository.updatePost(model);
  }

  Future<void> deletePost({
    required String postId,
    required String userId,
  }) async {
    final model = PostModel(id: postId, userId: userId);
    await _repository.deletePost(model);
  }

  Future<PostModel> createPost({
    required String userId,
    required String title,
    required String body,
  }) async {
    final model = PostModel(userId: userId, title: title, body: body);
    return await _repository.createPost(model);
  }
}
