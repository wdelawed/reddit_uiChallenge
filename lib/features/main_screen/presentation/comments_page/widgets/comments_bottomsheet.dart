import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/widgets/user_header_widget.dart';
import 'package:reddit_ui_challenge/features/main_screen/presentation/comments_page/widgets/video_actions__row_widget.dart';

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
    return Container(
      padding: const EdgeInsets.all(16),
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
          !showHeader
              ? const UserHeaderWidget()
              : const VideoActionsRowWidget(),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .71,
              child: ListView.builder(
                  controller: widget.scrollController,
                  itemCount: 30,
                  itemBuilder: (_, i) {
                    return ListTile(
                      leading: Text("Hello"),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
