import 'package:flutter/material.dart';

class FilterByWidget extends StatelessWidget {
  final Function()? onTap;
  final Color contentColor = Colors.grey.shade600;
  FilterByWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Icon(
                Icons.rocket,
                color: contentColor,
                size: 20,
              ),
              const SizedBox(width: 2),
              Text(
                "BEST COMMENTS",
                style: TextStyle(
                  color: contentColor,
                  fontSize: 12,
                  height: 20 / 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 2),
              RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.chevron_right,
                  color: contentColor,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
