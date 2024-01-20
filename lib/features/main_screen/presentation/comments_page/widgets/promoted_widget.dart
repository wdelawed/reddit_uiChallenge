import 'package:flutter/material.dart';

class PromotedWidget extends StatelessWidget {
  const PromotedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
