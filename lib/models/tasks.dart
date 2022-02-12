import 'package:flutter/material.dart';

class Task {
  final String title;
  final String desc;
  final DateTime deadline;
  final DateTime startDate;
  final String priority;
  final String id;
  Task({
    required this.title,
    required this.startDate,
    required this.desc,
    required this.priority,
    required this.deadline,
    required this.id,
  });
}
