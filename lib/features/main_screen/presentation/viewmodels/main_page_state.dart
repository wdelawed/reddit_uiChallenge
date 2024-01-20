import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/entities/reddit_video_entity.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/usecases/load_reddit_videos_usecase.dart';
import 'package:reddit_ui_challenge/shared/data/failure_model.dart';

class MainPageState {
  PageController mainPageController = PageController();
  int selectedPagIndex = 0;
  LoadState loadVideosState = LoadState.loading;
  LoadVideosParameters params = const LoadVideosParameters(page: 1, perPage: 3);
  List<RedditVideoEntity> videos = [];
  Failure? loadVideosError;

  LoadState upVoteVideoStatus = LoadState.init;
  int? upvoteVideoId; //track current video being upvoted

  LoadState downVoteVideoStatus = LoadState.init;
  int? downVoteVideoId; //track current video being downvoted
}

enum LoadState { init, loading, loaded, error }
