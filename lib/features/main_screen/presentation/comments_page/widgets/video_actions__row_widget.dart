import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/shared/presentation/colors.dart';

class VideoActionsRowWidget extends StatelessWidget {
  final bool upvoted;
  final bool downvoted;
  final Function()? onUpVote;
  final Function()? onDownVote;
  final Function()? onCommentTapped;
  final Function()? onShareTapped;
  final double iconSize = 24;
  const VideoActionsRowWidget({
    super.key,
    this.upvoted = false,
    this.downvoted = true,
    this.onCommentTapped,
    this.onDownVote,
    this.onShareTapped,
    this.onUpVote,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                const SizedBox(width: 16),
                Row(
                  children: [
                    InkWell(
                      onTap: onCommentTapped,
                      child: Icon(
                        CupertinoIcons.conversation_bubble,
                        color: Colors.grey,
                        size: iconSize,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "100",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: onShareTapped,
                      child: Icon(
                        CupertinoIcons.reply,
                        color: Colors.grey,
                        size: iconSize,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ],
            )),
        Divider(
          thickness: 1,
          color: Colors.grey.shade200,
        )
      ],
    );
  }
}
