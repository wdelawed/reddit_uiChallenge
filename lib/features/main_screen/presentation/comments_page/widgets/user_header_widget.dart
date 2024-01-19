import 'package:flutter/material.dart';
import 'package:reddit_ui_challenge/shared/presentation/colors.dart';

class UserHeaderWidget extends StatelessWidget {
  const UserHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: secondary,
              borderRadius: BorderRadius.circular(
                40,
              )),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Text(
            "bobloper1",
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
