class PostAuthorModel {
  PostAuthorModel({this.name, this.email, this.gender});

  final String? name;
  final String? email;
  final String? gender;

  PostAuthorModel copyWith({String? name, String? email, String? gender}) {
    return PostAuthorModel(
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
    );
  }

  factory PostAuthorModel.fromJson(Map<String, dynamic> json) {
    return PostAuthorModel(
      name: json['author_name'] as String?,
      email: json['author_email'] as String?,
      gender: json['author_gender'] as String?,
    );
  }
}
