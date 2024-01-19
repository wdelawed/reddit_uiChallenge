import 'package:either_dart/either.dart';
import 'package:reddit_ui_challenge/features/main_screen/data/models/video_model.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/usecases/load_reddit_videos_usecase.dart';
import 'package:reddit_ui_challenge/shared/data/failure_model.dart';

abstract class RedditVideosRepository {
  Future<Either<Failure, List<VideoModel>>> getVideos(
      LoadVideosParameters parameters);
}
