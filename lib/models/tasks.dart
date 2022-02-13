import 'package:flutter/material.dart';

class Task {
  final String title;
  final String desc;
  final DateTime deadline;
  final DateTime startDate;
  final String priority;
  final String id;
  final String user_id;
  final String user_task_id;
  final String status;
  Task({
    required this.title,
    required this.startDate,
    required this.desc,
    required this.priority,
    required this.deadline,
    required this.id,
    required this.user_id,
    required this.user_task_id,
    required this.status,
  });
}
