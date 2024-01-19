import 'dart:convert';

import 'package:reddit_ui_challenge/features/main_screen/domain/entities/video_comment_entity.dart';

import 'user.dart';

class Comment {
  num? id;
  String? text;
  String? dateTime;
  User? author;
  num? upvotes;
  num? downvotes;
  List<Comment>? replys;

  Comment({
    this.id,
    this.text,
    this.dateTime,
    this.author,
    this.upvotes,
    this.downvotes,
    this.replys,
  });

  VideoCommentEntity toEntity() => VideoCommentEntity(
        id: id?.toInt() ?? 0,
        text: text.toString(),
        dateTime: dateTime.toString(),
        author: author!.toEntity(),
        upvotes: upvotes?.toInt() ?? 0,
        downvotes: downvotes?.toInt() ?? 0,
        replys: replys?.map((e) => e.toEntity()).toList() ?? [],
      );

  factory Comment.fromMap(Map<String, dynamic> data) => Comment(
        id: num.tryParse(data['id'].toString()),
        text: data['text']?.toString(),
        dateTime: data['dateTime']?.toString(),
        author: data['author'] == null
            ? null
            : User.fromMap(Map<String, dynamic>.from(data['author'])),
        upvotes: num.tryParse(data['upvotes'].toString()),
        downvotes: num.tryParse(data['downvotes'].toString()),
        replys: (data['replys'] as List<dynamic>?)
            ?.map((e) => Comment.fromMap(Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (text != null) 'text': text,
        if (dateTime != null) 'dateTime': dateTime,
        if (author != null) 'author': author?.toMap(),
        if (upvotes != null) 'upvotes': upvotes,
        if (downvotes != null) 'downvotes': downvotes,
        if (replys != null) 'replys': replys?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Comment].
  factory Comment.fromJson(String data) {
    return Comment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Comment] to a JSON string.
  String toJson() => json.encode(toMap());

  Comment copyWith({
    num? id,
    String? text,
    String? dateTime,
    User? author,
    num? upvotes,
    num? downvotes,
    List<Comment>? replys,
  }) {
    return Comment(
      id: id ?? this.id,
      text: text ?? this.text,
      dateTime: dateTime ?? this.dateTime,
      author: author ?? this.author,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      replys: replys ?? this.replys,
    );
  }
}
