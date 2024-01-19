import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/usecases/load_reddit_videos_usecase.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/viewmodels/main_page_state.dart';
import 'package:reddit_ui_challenge/shared/data/failure_model.dart';
import 'package:reddit_ui_challenge/shared/presentation/video_played_provider.dart';

class MainPageViewModel extends ChangeNotifier {
  MainPageState state = MainPageState();

  LoadRedditVideosUseCase loadRedditVideosUseCase;

  MainPageViewModel({required this.loadRedditVideosUseCase});

  void loadVideos(VideoPlayerProvider videoPlayer) async {
    late Either res;
    try {
      res = await loadRedditVideosUseCase(params: state.params);
    } catch (e) {
      res = const Left(Failure(msg: "Unexpected Error while processing data"));
    }

    res.fold((failure) {
      state.loadVideosState = LoadState.error;
      state.loadVideosError = failure;

      notifyListeners();
    }, (videos) {
      state.loadVideosState = LoadState.loaded;
      state.videos = videos;
      videoPlayer.preloadVideos(videos);
      notifyListeners();
    });
  }

  void upvoteVideo(int videoId, int index) async {
    //simulate video upvoting
    state.upVoteVideoStatus = LoadState.loading;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    state.upVoteVideoStatus = LoadState.loaded;
    state.videos[index].upvotes += 1;
    if (state.videos[index].downvoted) state.videos[index].downvotes -= 1;
    state.videos[index].downvoted = false;
    state.videos[index].upvoted = true;

    state.upvoteVideoId = videoId;
    notifyListeners();
  }

  void cancelUpvoteVideo(int videoId, int index) async {
    state.upVoteVideoStatus = LoadState.loading;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    state.upVoteVideoStatus = LoadState.loaded;
    state.videos[index].upvotes -= 1;
    state.videos[index].upvoted = false;

    state.upvoteVideoId = videoId;
    notifyListeners();
  }

  void cancelDownVoteVideo(int videoId, int index) async {
    state.downVoteVideoStatus = LoadState.loading;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    state.downVoteVideoStatus = LoadState.loaded;
    state.videos[index].downvotes -= 1;
    state.videos[index].downvoted = false;

    state.downVoteVideoId = videoId;
    notifyListeners();
  }

  void downVoteVideo(int videoId, int index) async {
    //simulate video upvoting
    state.downVoteVideoStatus = LoadState.loading;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    state.downVoteVideoStatus = LoadState.loaded;
    state.videos[index].downvotes += 1;

    if (state.videos[index].upvoted) state.videos[index].upvotes -= 1;
    state.videos[index].downvoted = true;
    state.videos[index].upvoted = false;

    state.downVoteVideoId = videoId;
    notifyListeners();
  }
}
