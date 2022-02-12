import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';

class PriorityIndicator extends StatelessWidget {
  const PriorityIndicator({
    Key? key,
    required this.priority,
    required this.color,
  }) : super(key: key);
  final String priority;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: 15,
          height: 15,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        Text(
          priority,
          style: subtitlestyle.copyWith(fontSize: 15),
        )
      ],
    );
  }
}