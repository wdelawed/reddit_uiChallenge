import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/widgets/comments_bottomsheet.dart';
import 'package:reddit_ui_challenge/shared/presentation/video_played_provider.dart';
import 'package:video_player/video_player.dart';

class VideoCommentsPage extends StatefulWidget {
  final VideoState videoState;
  const VideoCommentsPage({
    super.key,
    required this.videoState,
  });

  @override
  State<VideoCommentsPage> createState() => _VideoCommentsPageState();
}

class _VideoCommentsPageState extends State<VideoCommentsPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              LayoutBuilder(builder: (context, constraints) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Hero(
                    tag: "Video",
                    child: Align(
                      alignment: Alignment.topCenter,
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
                );
              }),
              NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  if (notification.extent == notification.minExtent) {
                    Navigator.pop(context);
                  }
                  return true;
                },
                child: DraggableScrollableSheet(
                  //   controller: controller,
                  initialChildSize: .71,
                  maxChildSize: 1,
                  minChildSize: .4,
                  //snapAnimationDuration: const Duration(milliseconds: 200),
                  snap: false,
                  // snapSizes: const [.71, 1],
                  shouldCloseOnMinExtent: true,
                  builder: (context, scrollController) {
                    return CommentsBottomSheet(
                      scrollController: scrollController,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
