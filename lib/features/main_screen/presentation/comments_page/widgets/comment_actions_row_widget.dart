import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/entities/video_comment_entity.dart';
import 'package:reddit_ui_challenge/shared/presentation/colors.dart';

class CommentActionsRowWidget extends StatelessWidget {
  final bool upvoted;
  final bool downvoted;
  final VideoCommentEntity comment;
  final int level;
  final Function()? onUpVote;
  final Function()? onDownVote;
  final Function()? onMoreTapped;
  final Function()? onShareTapped;
  final double iconSize = 24;
  const CommentActionsRowWidget({
    super.key,
    required this.comment,
    this.level = 1,
    this.upvoted = false,
    this.downvoted = true,
    this.onMoreTapped,
    this.onDownVote,
    this.onShareTapped,
    this.onUpVote,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(child: SizedBox()),
        Row(
          children: [
            InkWell(
              onTap: onMoreTapped,
              child: Icon(
                Icons.more_vert,
                color: Colors.grey,
                size: iconSize,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(width: 12),
        Row(
          children: [
            InkWell(
              onTap: onShareTapped,
              child: Icon(
                Icons.reply,
                color: Colors.grey,
                size: iconSize,
              ),
            ),
            level <= 1 ? const SizedBox(width: 10) : const SizedBox(),
            level <= 1
                ? const Text(
                    "Reply",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(width: 24),
        Row(
          children: [
            InkWell(
              onTap: onUpVote,
              child: Icon(
                upvoted
                    ? CupertinoIcons.arrow_up_square_fill
                    : CupertinoIcons.arrow_up_square,
                color: upvoted ? primary : Colors.grey,
                size: iconSize,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "987",
              style: TextStyle(
                color: upvoted
                    ? primary
                    : downvoted
                        ? secondary
                        : Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                height: 2.2,
              ),
            ),
            const SizedBox(width: 4),
            InkWell(
              onTap: onDownVote,
              child: Icon(
                downvoted
                    ? CupertinoIcons.arrow_down_square_fill
                    : CupertinoIcons.arrow_down_square,
                color: downvoted ? secondary : Colors.grey,
                size: iconSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
