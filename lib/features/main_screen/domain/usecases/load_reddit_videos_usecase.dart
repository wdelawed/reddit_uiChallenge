import 'package:reddit_ui_challenge/features/main_screen/domain/entities/reddit_video_entity.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/repositories/reddit_videos_repository.dart';
import 'package:reddit_ui_challenge/shared/data/failure_model.dart';
import 'package:either_dart/either.dart';

class LoadRedditVideosUseCase {
  RedditVideosRepository redditVideosRepository;
  LoadRedditVideosUseCase({required this.redditVideosRepository});
  Future<Either<Failure, List<RedditVideoEntity>>> call(
      {required LoadVideosParameters params}) async {
    try {
      final data = await redditVideosRepository.getVideos(params);
      return data.fold(
        (failure) => Left(failure),
        (videoModels) => Right(videoModels.map((e) => e.toEntity()).toList()),
      );
    } catch (e) {
      //handle any enexpected  error in repo
      return const Left(Failure(msg: "Error fetching data"));
    }
  }
}

class LoadVideosParameters {
  final int page;
  final int perPage;
  const LoadVideosParameters({required this.page, required this.perPage});
}
