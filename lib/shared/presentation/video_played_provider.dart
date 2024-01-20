import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/entities/reddit_video_entity.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider extends ChangeNotifier {
  List<VideoState> states = [];
  VideoState? currentVideoState;
  bool soundEnabled = false;
  void preloadVideos(List<RedditVideoEntity> videos) async {
    states = videos
        .map((video) => VideoState(
              video: video,
              videoPlayerController: VideoPlayerController.networkUrl(
                Uri.parse(video.videoUrl),
              ),
              playStatus: VideoPlayStatus.loading,
            ))
        .toList();
    // try {
    //   await states[0].videoPlayerController.initialize();
    //   states[0].playStatus = VideoPlayStatus.loadingSuccess;
    //   setCurrentVideo(0);
    // } catch (e) {
    //   states[0].playStatus = VideoPlayStatus.loadingfailed;
    //   notifyListeners();
    //   setCurrentVideo(0);
    // }

    for (int i = 0; i < videos.length; i++) {
      try {
        await states[i].videoPlayerController.initialize();

        states[i].videoPlayerController.setVolume(1);
        soundEnabled = true;
        notifyListeners();
        if (i == 0) {
          setCurrentVideo(0);
          // await Future.delayed(const Duration(milliseconds: 2000));
          states[i].playStatus = VideoPlayStatus.loadingSuccess;
          playVideo(states[i].video.id);
          notifyListeners();
        } else {
          states[i].playStatus = VideoPlayStatus.loadingSuccess;
          notifyListeners();
        }

        states[i].videoPlayerController.addListener(() {
          onUpdate(i, states[i]);
        });
      } catch (e) {
        states[i].playStatus = VideoPlayStatus.loadingfailed;
        notifyListeners();
      }
    }
  }

  void onUpdate(int index, VideoState state) {
    notifyListeners();
  }

  void setCurrentVideo(int index) {
    if (currentVideoState != null &&
        currentVideoState!.playStatus == VideoPlayStatus.playing) {
      //stop the old video if it's playing
      pauseVideo(currentVideoState!.video.id);
    }
    currentVideoState = states[index];
    notifyListeners();
  }

  void toggleSound() {
    if (currentVideoState == null) return;
    soundEnabled = !soundEnabled;
    notifyListeners();
    if (soundEnabled) {
      currentVideoState!.videoPlayerController.setVolume(.6);
    } else {
      currentVideoState!.videoPlayerController.setVolume(0);
    }
  }

  void playVideo(int videoId) {
    if (currentVideoState == null) return;
    if (videoId != currentVideoState!.video.id) return; //video must be selected
    if ((currentVideoState!.playStatus == VideoPlayStatus.loadingSuccess ||
        currentVideoState!.playStatus == VideoPlayStatus.paused)) {
      currentVideoState!.videoPlayerController.play();
      currentVideoState!.playStatus = VideoPlayStatus.playing;
      notifyListeners();
    }
  }

  void seekVideo(int videoId, Duration duration) {
    if (currentVideoState == null) return;
    if (videoId != currentVideoState!.video.id) return; //video must be selected

    if ((currentVideoState!.playStatus == VideoPlayStatus.playing ||
        currentVideoState!.playStatus == VideoPlayStatus.paused)) {
      currentVideoState!.videoPlayerController.seekTo(duration);
      currentVideoState!.videoPlayerController.play();
      currentVideoState!.playStatus = VideoPlayStatus.playing;
      notifyListeners();
    }
  }

  void pauseVideo(int videoId) {
    if (currentVideoState == null) return;
    if (videoId != currentVideoState!.video.id) return; //video must be selected
    if (currentVideoState!.playStatus == VideoPlayStatus.playing) {
      currentVideoState!.videoPlayerController.pause();

      currentVideoState!.playStatus = VideoPlayStatus.paused;
      notifyListeners();
    }
  }
}

class VideoState {
  RedditVideoEntity video;
  VideoPlayerController videoPlayerController;
  VideoPlayStatus playStatus;
  Duration totalDuration;
  double playPercent;

  VideoState({
    required this.video,
    required this.videoPlayerController,
    this.playStatus = VideoPlayStatus.init,
    this.totalDuration = const Duration(seconds: 0),
    this.playPercent = 0.0,
  });
}

enum VideoPlayStatus {
  init,
  loading,
  loadingSuccess,
  loadingfailed,
  playing,
  paused,
  stopped,
}
