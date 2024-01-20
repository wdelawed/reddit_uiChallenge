import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/widgets/comment_widget.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/widgets/filter_by_widget.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/widgets/user_header_widget.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/widgets/video_actions__row_widget.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/viewmodels/main_page_viewmodel.dart';

import 'promoted_widget.dart';

class CommentsBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  const CommentsBottomSheet({
    super.key,
    required this.scrollController,
  });

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  bool showHeader = false;
  @override
  void initState() {
    widget.scrollController.addListener(() {
      if (widget.scrollController.offset > 20 && showHeader == false) {
        setState(() {
          showHeader = true;
        });
      } else if (widget.scrollController.offset <= 20 && showHeader == true) {
        setState(() {
          showHeader = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageViewModel>(builder: (context, viewModel, child) {
      final currentVideo =
          viewModel.state.videos[viewModel.state.selectedPagIndex];
      return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 20),
            //drag handle
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            //actions header
            !showHeader
                ? UserHeaderWidget(
                    authorName: currentVideo.user.name,
                    authorImage: currentVideo.user.imageUrl,
                  )
                : const VideoActionsRowWidget(),
            const SizedBox(height: 4),
            // comments
            Expanded(
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentVideo.videoTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Lorem Ipsum is simply dummy text of the printing and . ",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24,
                      thickness: 8,
                      color: Colors.grey.shade200,
                    ),
                    const PromotedWidget(),
                    FilterByWidget(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: currentVideo.comments.length,
                      itemBuilder: (_, i) {
                        return CommentWidget(
                          comment: currentVideo.comments[i],
                          groupLogoUrl: currentVideo.groupLogo,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
