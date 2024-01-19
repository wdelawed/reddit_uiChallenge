import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/entities/reddit_video_entity.dart';
import 'package:reddit_ui_challenge/shared/presentation/colors.dart';

class VideoActionsWidget extends StatelessWidget {
  final RedditVideoEntity video;
  final Function()? onUpVote;
  final Function()? onDownVote;
  final Function()? onCommentTapped;
  final Function()? onShareTapped;
  const VideoActionsWidget({
    super.key,
    required this.video,
    this.onCommentTapped,
    this.onDownVote,
    this.onShareTapped,
    this.onUpVote,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                video.user.imageUrl))),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Text(
                      video.user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                video.videoTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 2,
                ),
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          Column(
            children: [
              InkWell(
                onTap: onUpVote,
                child: Icon(
                  video.upvoted
                      ? CupertinoIcons.arrow_up_square_fill
                      : CupertinoIcons.arrow_up_square,
                  color: video.upvoted ? primary : Colors.white,
                  size: 30,
                ),
              ),
              AnimatedFlipCounter(
                duration: const Duration(milliseconds: 500),
                value: video.upvotes - video.downvotes,
                textStyle: TextStyle(
                  color: video.upvoted
                      ? primary
                      : video.downvoted
                          ? secondary
                          : Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  height: 2.2,
                ), // pass in a value like 2014
              ),
              InkWell(
                onTap: onDownVote,
                child: Icon(
                  video.downvoted
                      ? CupertinoIcons.arrow_down_square_fill
                      : CupertinoIcons.arrow_down_square,
                  color: video.downvoted ? secondary : Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: onCommentTapped,
                child: const Icon(
                  CupertinoIcons.conversation_bubble,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Text(
                video.commentsCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  height: 2,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: onShareTapped,
                child: const RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    CupertinoIcons.reply,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
}
