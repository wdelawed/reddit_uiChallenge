import 'package:reddit_ui_challenge/features/main_screen/domain/entities/reddit_user_entity.dart';

class VideoCommentEntity {
  final int id;
  final String text;
  final String dateTime;

  final int upvotes;
  final int downvotes;

  final RedditUserEntity author;

  final List<VideoCommentEntity> replys;

  const VideoCommentEntity({
    required this.id,
    required this.text,
    required this.dateTime,
    required this.author,
    required this.upvotes,
    required this.downvotes,
    required this.replys,
  });
}
