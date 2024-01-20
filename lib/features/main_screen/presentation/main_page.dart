import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/viewmodels/main_page_state.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/viewmodels/main_page_viewmodel.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/widgets/reddit_video_widget.dart';
import 'package:reddit_ui_challenge/shared/presentation/video_played_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageViewModel>(builder: (context, viewModel, child) {
      return Material(
        color: Colors.black,
        child: Stack(children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                )
              ],
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          viewModel.state.loadVideosState == LoadState.loading
              ? const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: viewModel.state.videos.length,
                    scrollDirection: Axis.vertical,
                    controller: viewModel.state.mainPageController,
                    onPageChanged: (index) {
                      viewModel.setSelectedPapgeIndex(index);
                      context
                          .read<VideoPlayerProvider>()
                          .setCurrentVideo(index);
                      context
                          .read<VideoPlayerProvider>()
                          .playVideo(viewModel.state.videos[index].id);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return RedditVideoWidget(
                        videoState:
                            context.read<VideoPlayerProvider>().states[index],
                        index: index,
                      );
                    },
                  ),
                )
        ]),
      );
    });
  }
}
