import 'dart:convert';

import 'package:reddit_ui_challenge/features/main_screen/domain/entities/reddit_video_entity.dart';

import 'comment.dart';
import 'user.dart';

class VideoModel {
  num? id;
  String? groupLogo;
  String? groupName;
  User? user;
  List<Comment>? comments;
  num? commentsCount;
  num? downvotes;
  num? upvotes;
  bool? upvoted;
  bool? downvoted;
  String? videoTitle;
  String? videoUrl;

  VideoModel({
    this.id,
    this.groupLogo,
    this.groupName,
    this.user,
    this.comments,
    this.commentsCount,
    this.downvotes,
    this.upvotes,
    this.upvoted,
    this.downvoted,
    this.videoTitle,
    this.videoUrl,
  });

  RedditVideoEntity toEntity() => RedditVideoEntity(
        id: id?.toInt() ?? 0,
        groupLogo: groupLogo.toString(),
        groupName: groupName.toString(),
        user: user!.toEntity(),
        comments: comments?.map((e) => e.toEntity()).toList() ?? [],
        commentsCount: commentsCount?.toInt() ?? 0,
        downvotes: downvotes?.toInt() ?? 0,
        upvotes: upvotes?.toInt() ?? 0,
        upvoted: upvoted ?? false,
        downvoted: downvoted ?? false,
        videoTitle: videoTitle.toString(),
        videoUrl: videoUrl.toString(),
      );

  factory VideoModel.fromMap(Map<String, dynamic> data) => VideoModel(
        id: num.tryParse(data['id'].toString()),
        groupLogo: data['groupLogo']?.toString(),
        groupName: data['groupName']?.toString(),
        user: data['user'] == null
            ? null
            : User.fromMap(Map<String, dynamic>.from(data['user'])),
        comments: (data['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromMap(Map<String, dynamic>.from(e)))
            .toList(),
        commentsCount: num.tryParse(data['commentsCount'].toString()),
        downvotes: num.tryParse(data['downvotes'].toString()),
        upvotes: num.tryParse(data['upvotes'].toString()),
        upvoted: data['upvoted']?.toString().contains("true"),
        downvoted: data['downvoted']?.toString().contains("true"),
        videoTitle: data['videoTitle']?.toString(),
        videoUrl: data['videoUrl']?.toString(),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (groupLogo != null) 'groupLogo': groupLogo,
        if (groupName != null) 'groupName': groupName,
        if (user != null) 'user': user?.toMap(),
        if (comments != null)
          'comments': comments?.map((e) => e.toMap()).toList(),
        if (commentsCount != null) 'commentsCount': commentsCount,
        if (downvotes != null) 'downvotes': downvotes,
        if (upvotes != null) 'upvotes': upvotes,
        if (upvoted != null) 'upvoted': upvoted,
        if (downvoted != null) 'downvoted': downvoted,
        if (videoTitle != null) 'videoTitle': videoTitle,
        if (videoUrl != null) 'videoUrl': videoUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VideoModel].
  factory VideoModel.fromJson(String data) {
    return VideoModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VideoModel] to a JSON string.
  String toJson() => json.encode(toMap());

  VideoModel copyWith({
    num? id,
    String? groupLogo,
    String? groupName,
    User? user,
    List<Comment>? comments,
    num? commentsCount,
    num? downvotes,
    num? upvotes,
    bool? upvoted,
    bool? downvoted,
    String? videoTitle,
    String? videoUrl,
  }) {
    return VideoModel(
      id: id ?? this.id,
      groupLogo: groupLogo ?? this.groupLogo,
      groupName: groupName ?? this.groupName,
      user: user ?? this.user,
      comments: comments ?? this.comments,
      commentsCount: commentsCount ?? this.commentsCount,
      downvotes: downvotes ?? this.downvotes,
      upvotes: upvotes ?? this.upvotes,
      upvoted: upvoted ?? this.upvoted,
      downvoted: downvoted ?? this.downvoted,
      videoTitle: videoTitle ?? this.videoTitle,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
