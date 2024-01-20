import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/shared/presentation/colors.dart';

class UserHeaderWidget extends StatelessWidget {
  final String authorName;
  final String authorImage;
  const UserHeaderWidget({
    super.key,
    required this.authorName,
    required this.authorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: secondary,
              borderRadius: BorderRadius.circular(
                40,
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  authorImage,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Text(
            authorName,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
