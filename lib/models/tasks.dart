import 'package:flutter/material.dart';

class Task {
  final String title;
  final String desc;
  final DateTime deadline;
  final String priority;
  Task(
      {required this.title,
      required this.desc,
      required this.priority,
      required this.deadline,});
}