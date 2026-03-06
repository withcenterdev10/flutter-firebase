import 'package:fb_test2/models/post/post.author_model.dart';

class PostModel {
  PostModel({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.createdAt,
    this.updatedAt,
    this.author,
  });

  final String? id;
  final String? userId;
  final String? title;
  final String? body;
  final String? createdAt;
  final String? updatedAt;
  final PostAuthorModel? author;

  PostModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    String? createdAt,
    String? updatedAt,
    PostAuthorModel? author,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      author: author ?? this.author,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      author: PostAuthorModel.fromJson(json),
    );
  }
}
