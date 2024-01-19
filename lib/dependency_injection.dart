import 'package:get_it/get_it.dart';
import 'package:reddit_ui_challenge/features/main_screen/data/datasources/videos_datasource.dart';
import 'package:reddit_ui_challenge/features/main_screen/data/repositories/reddit_videos_repository_impl.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/repositories/reddit_videos_repository.dart';
import 'package:reddit_ui_challenge/features/main_screen/domain/usecases/load_reddit_videos_usecase.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/viewmodels/main_page_viewmodel.dart';
import 'package:reddit_ui_challenge/shared/presentation/video_played_provider.dart';

final di = GetIt.asNewInstance();
void initDI() {
  di.registerLazySingleton<VideoPlayerProvider>(() => VideoPlayerProvider());

  di.registerLazySingleton<VideosDataSource>(() => VideosDataSource());
  di.registerFactory<RedditVideosRepository>(
    () => RedditVideosRepositoryImpl(dataSource: di<VideosDataSource>()),
  );
  di.registerFactory<LoadRedditVideosUseCase>(
    () => LoadRedditVideosUseCase(
        redditVideosRepository: di<RedditVideosRepository>()),
  );
  di.registerLazySingleton<MainPageViewModel>(() => MainPageViewModel(
        loadRedditVideosUseCase: di<LoadRedditVideosUseCase>(),
      ));
}
