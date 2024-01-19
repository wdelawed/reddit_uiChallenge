import 'package:either_dart/src/either.dart';
import 'package:reddit_ui_challenge/features/main_screen/data/datasources/videos_datasource.dart';
import 'package:reddit_ui_challenge/features/main_screen/data/models/video_model.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/repositories/reddit_videos_repository.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/usecases/load_reddit_videos_usecase.dart';
import 'package:reddit_ui_challenge/shared/data/failure_model.dart';

class RedditVideosRepositoryImpl implements RedditVideosRepository {
  final VideosDataSource dataSource;
  RedditVideosRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<VideoModel>>> getVideos(
      LoadVideosParameters parameters) async {
    late List<Map<String, dynamic>> res;
    try {
      res = await dataSource.getVideos();
    } catch (e) {
      //handle unexpected datasource exceptions
      return const Left(
          Failure(msg: "Unexpected Error while fetching data from internet"));
    }
    return Right(res.map((e) => VideoModel.fromMap(e)).toList());
  }
}
