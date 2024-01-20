import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/widgets/comments_bottomsheet.dart';
import 'package:reddit_ui_challenge/shared/presentation/video_played_provider.dart';
import 'package:video_player/video_player.dart';

class VideoCommentsPage extends StatefulWidget {
  final VideoState videoState;
  final double fullWidth;
  final double fullHeight;
  const VideoCommentsPage({
    super.key,
    required this.videoState,
    required this.fullWidth,
    required this.fullHeight,
  });

  @override
  State<VideoCommentsPage> createState() => _VideoCommentsPageState();
}

class _VideoCommentsPageState extends State<VideoCommentsPage>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  Offset? dragStartPosition;

  bool shouldExpandBottomSheet = false;

  double initialExtent = 0.72;
  double maxExtent = 1;
  double minExtent = .5;

  List<double> snappingPositions = [0.4, 0.71, 1];

  Offset? dragStartOffset;
  Offset? dargCurrentPosition;

  late double position;

  double minimumVideoPlayerExtent = .28;

  double delta = 0;

  @override
  void initState() {
    position = initialExtent * widget.fullHeight;

    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          position = maxExtent * widget.fullHeight;
        });
      } else if (scrollController.offset ==
          scrollController.position.minScrollExtent) {
        setState(() {
          position = initialExtent * widget.fullHeight;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: MediaQuery.of(context).size.width,
              height: max(MediaQuery.of(context).size.height - position,
                  widget.fullHeight * minimumVideoPlayerExtent),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Hero(
                    tag: "Video",
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height *
                            widget.videoState.videoPlayerController.value
                                .aspectRatio,
                        height: MediaQuery.of(context).size.height * .28,
                        child: VideoPlayer(
                          widget.videoState.videoPlayerController,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: getBottomSheet())
          ],
        ),
      ),
    );
  }

  void onClose() {
    Navigator.pop(context);
  }

  Widget getBottomSheet() {
    return GestureDetector(
      onVerticalDragStart: (details) {
        dragStartOffset = details.globalPosition;
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          delta = details.delta.dy;
          position = position - delta;
          dargCurrentPosition = details.globalPosition;
        });
      },
      onVerticalDragEnd: (details) {
        double minDistance = (((1 - snappingPositions[0]) * widget.fullHeight) -
                dargCurrentPosition!.dy)
            .abs();
        double positionToSnapTo = snappingPositions[0];
        for (var snapPosition in snappingPositions) {
          final distance = (((1 - snapPosition) * widget.fullHeight) -
                  dargCurrentPosition!.dy)
              .abs();
          if (distance < minDistance) {
            minDistance = distance;
            positionToSnapTo = snapPosition;
          }
        }
        setState(() {
          delta = (((1 - positionToSnapTo) * widget.fullHeight) -
              dargCurrentPosition!.dy);
          position = position - delta;
          if (position < (minExtent * widget.fullHeight)) {
            onClose();
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: max(
            min(position, MediaQuery.of(context).size.height * maxExtent),
            MediaQuery.of(context).size.height * minExtent),
        child: CommentsBottomSheet(
          scrollController: scrollController,
        ),
      ),
    );
  }
}
