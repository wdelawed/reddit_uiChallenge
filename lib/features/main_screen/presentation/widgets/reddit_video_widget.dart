import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/viewmodels/main_page_viewmodel.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/widgets/video_actions_widget.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/widgets/video_controls_widget.dart';
import 'package:reddit_ui_challenge/shared/presentation/video_played_provider.dart';
import 'package:video_player/video_player.dart';

class RedditVideoWidget extends StatefulWidget {
  final VideoState videoState;
  final int index;

  const RedditVideoWidget(
      {super.key, required this.videoState, required this.index});

  @override
  State<RedditVideoWidget> createState() => _RedditVideoWidgetState();
}

class _RedditVideoWidgetState extends State<RedditVideoWidget> {
  final videoPlayerKey = GlobalKey();
  @override
  void initState() {
    context.read<VideoPlayerProvider>().playVideo(widget.videoState.video.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Stack(
          children: [
            Hero(
              tag: "Video",
              child: Consumer<VideoPlayerProvider>(
                  builder: (context, videoPlayerProvider, child) {
                final currentVideo = videoPlayerProvider.currentVideoState;
                if (currentVideo == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  );
                }
                return Align(
                  alignment: Alignment.center,
                  child: currentVideo.playStatus == VideoPlayStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        )
                      : currentVideo.playStatus == VideoPlayStatus.loadingfailed
                          ? const Center(
                              child: Text(
                                "Failed to Play Video",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width /
                                      currentVideo.videoPlayerController.value
                                          .aspectRatio,
                                  child: VideoPlayer(
                                    currentVideo.videoPlayerController,
                                    key: videoPlayerKey,
                                  ),
                                ),
                              ),
                            ),
                );
              }),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    widget.videoState.video.user.imageUrl))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 16),
                        child: Text(
                          widget.videoState.video.videoTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        VideoActionsWidget(
                          video: widget.videoState.video,
                          onCommentTapped: () {
                            Navigator.pushNamed(context, "comments",
                                arguments: widget.videoState);
                          },
                          onUpVote: () {
                            if (widget.videoState.video.upvoted) {
                              context
                                  .read<MainPageViewModel>()
                                  .cancelUpvoteVideo(
                                      widget.videoState.video.id, widget.index);
                            } else {
                              context.read<MainPageViewModel>().upvoteVideo(
                                  widget.videoState.video.id, widget.index);
                            }
                          },
                          onDownVote: () {
                            if (widget.videoState.video.downvoted) {
                              context
                                  .read<MainPageViewModel>()
                                  .cancelDownVoteVideo(
                                      widget.videoState.video.id, widget.index);
                            } else {
                              context.read<MainPageViewModel>().downVoteVideo(
                                  widget.videoState.video.id, widget.index);
                            }
                          },
                          onShareTapped: () {},
                        ),
                        VideoControls(videoState: widget.videoState),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
