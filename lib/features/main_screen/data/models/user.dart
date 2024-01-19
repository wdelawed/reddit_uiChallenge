import 'dart:convert';

import 'package:reddit_ui_challenge/features/main_screen/domain/entities/reddit_user_entity.dart';

class User {
  num? id;
  String? name;
  String? imageUrl;

  User({this.id, this.name, this.imageUrl});

  RedditUserEntity toEntity() => RedditUserEntity(
        id: id?.toInt() ?? 0,
        name: name.toString(),
        imageUrl: imageUrl.toString(),
      );

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: num.tryParse(data['id'].toString()),
        name: data['name']?.toString(),
        imageUrl: data['imageUrl']?.toString(),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (imageUrl != null) 'imageUrl': imageUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  User copyWith({
    num? id,
    String? name,
    String? imageUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
