import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/entities/video_comment_entity.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/widgets/comment_actions_row_widget.dart';

class CommentWidget extends StatelessWidget {
  final int commentLevel;
  final VideoCommentEntity comment;
  final String groupLogoUrl;
  const CommentWidget(
      {super.key,
      required this.comment,
      this.commentLevel = 1,
      this.groupLogoUrl = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: commentLevel > 1 ? 0 : 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: commentLevel > 1
              ? Border(
                  left: BorderSide(
                  width: 2,
                  color: Colors.grey.shade300,
                ))
              : null,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              comment.author.imageUrl))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        comment.author.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(groupLogoUrl),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "1d", //comment.dateTime,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "33 ${comment.text}", //comment.dateTime,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            CommentActionsRowWidget(
              comment: comment,
              level: commentLevel,
            ),
            if (comment.replys.isNotEmpty)
              Column(
                children: comment.replys
                    .map((e) => CommentWidget(
                          comment: e,
                          commentLevel: commentLevel + 1,
                        ))
                    .toList(),
              )
          ],
        ),
      ),
    );
  }
}
