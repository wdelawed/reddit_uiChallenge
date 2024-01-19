import 'package:reddit_ui_challenge/features/main_screen/domain/entities/reddit_user_entity.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/entities/video_comment_entity.dart';

class RedditVideoEntity {
  final int id;
  final String groupName;
  final String groupLogo;
  final RedditUserEntity user;
  final String videoUrl;
  final String videoTitle;
  int upvotes;
  int downvotes;
  bool upvoted;
  bool downvoted;
  final int commentsCount;

  final List<VideoCommentEntity> comments;

  RedditVideoEntity({
    required this.id,
    required this.groupLogo,
    required this.groupName,
    required this.user,
    required this.comments,
    required this.commentsCount,
    required this.downvotes,
    required this.upvotes,
    required this.upvoted,
    required this.downvoted,
    required this.videoTitle,
    required this.videoUrl,
  });
}
