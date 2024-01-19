import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_ui_challenge/shared/presentation/video_played_provider.dart';

class VideoControls extends StatelessWidget {
  final VideoState videoState;
  const VideoControls({
    super.key,
    required this.videoState,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPlayerProvider>(
        builder: (context, videoPlayer, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                if (videoState.playStatus == VideoPlayStatus.playing) {
                  videoPlayer.pauseVideo(videoState.video.id);
                } else {
                  if (videoState.playStatus == VideoPlayStatus.loadingfailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Failed to load video"),
                      ),
                    );
                  } else {
                    videoPlayer.playVideo(videoState.video.id);
                  }
                }
              },
              child: Icon(
                videoState.playStatus == VideoPlayStatus.playing
                    ? CupertinoIcons.pause_solid
                    : CupertinoIcons.play_arrow_solid,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Slider(
                secondaryTrackValue: 0,
                value: videoState.playStatus == VideoPlayStatus.loadingfailed ||
                        videoState.playStatus == VideoPlayStatus.loading
                    ? 0
                    : _getSliderValue(videoState),
                onChanged: (v) {
                  if (videoState.playStatus != VideoPlayStatus.init &&
                      videoState.playStatus != VideoPlayStatus.loading &&
                      videoState.playStatus != VideoPlayStatus.loadingfailed) {
                    final duration = videoState
                            .videoPlayerController.value.duration.inSeconds *
                        v;
                    videoPlayer.seekVideo(videoState.video.id,
                        Duration(seconds: duration.toInt()));
                  }
                },
                activeColor: Colors.white,
                inactiveColor: Colors.white.withOpacity(.3),
                thumbColor: Colors.white,
                secondaryActiveColor: Colors.white.withOpacity(.5),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              (videoState.playStatus != VideoPlayStatus.playing) ||
                      (videoState.playStatus != VideoPlayStatus.paused) ||
                      videoState.playStatus != VideoPlayStatus.stopped
                  ? _formatDuration(
                      videoState.videoPlayerController.value.position)
                  : "00:00",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                videoPlayer.toggleSound();
              },
              child: Icon(
                videoPlayer.soundEnabled
                    ? CupertinoIcons.volume_up
                    : CupertinoIcons.volume_mute,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      );
    });
  }

  _formatDuration(Duration? position) {
    if (position == null) {
      return "00:00";
    } else {
      final seconds = position.inSeconds % 60;
      final minutes = (position.inSeconds / 60).floorToDouble().toInt();
      return "${_padZero(minutes.toString())}:${_padZero(seconds.toString())}";
    }
  }

  String _padZero(String number) {
    if (number.length == 1) {
      return "0$number";
    }
    return number;
  }

  double _getSliderValue(VideoState videoState) {
    final v = videoState.videoPlayerController.value.position.inSeconds /
        videoState.videoPlayerController.value.duration.inSeconds;
    return v < 0
        ? 0
        : v > 1
            ? 1
            : v;
  }
}
