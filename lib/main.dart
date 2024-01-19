import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_ui_challenge/dependency_injection.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/video_comments_page.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/main_page.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/viewmodels/main_page_viewmodel.dart';
import 'package:reddit_ui_challenge/shared/helpers.dart';
import 'package:reddit_ui_challenge/shared/presentation/theme.dart';
import 'package:reddit_ui_challenge/shared/presentation/video_played_provider.dart';

void main() {
  initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di<VideoPlayerProvider>()),
        ChangeNotifierProvider(
          create: (_) =>
              di<MainPageViewModel>()..loadVideos(di<VideoPlayerProvider>()),
        ),
      ],
      child: MaterialApp(
        title: 'Reddit Ui',
        initialRoute: "/",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/":
              return Routing.createRoute(const MainPage());
            case "comments":
              return Routing.createRoute(VideoCommentsPage(
                videoState: settings.arguments as VideoState,
              ));
          }
          return null;
        },
        theme: getTheme(brightness: Brightness.light),
      ),
    );
  }
}
