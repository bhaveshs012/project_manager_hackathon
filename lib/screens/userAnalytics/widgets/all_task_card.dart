import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/tasks.dart';
import 'dart:math' as math;

import 'all_tasks_details.dart';

class AllTaskCard extends StatefulWidget {
  AllTaskCard({Key? key, required this.tasks, required this.project})
      : super(key: key);
  final Task tasks;
  final Project project;

  @override
  State<AllTaskCard> createState() => _AllTaskCardState();
}

class _AllTaskCardState extends State<AllTaskCard> {
  bool is_reviewed = false;
  _changeUserTask(String user_id, String task_id) {
    DocumentReference _userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .collection('tasks')
        .doc(task_id);
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference _taskRef = FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.project.id)
        .collection('tasks')
        .doc(widget.tasks.id);
    DocumentReference _userTaskRef = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.tasks.user_id)
        .collection('tasks')
        .doc(widget.tasks.user_task_id);

    return ListTile(
        onTap: () => Get.to(
            AllTaskDetailScreen(tasks: widget.tasks, project: widget.project)),
        title: Text(widget.tasks.title),
        leading: CircleAvatar(
          backgroundColor:
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
          child: Text(
            widget.tasks.title[0],
            style: TextStyle(color: Colors.white),
          ),
        ),
        subtitle: Text(widget.tasks.desc),
        trailing: CircleAvatar(
          backgroundColor: is_reviewed ? Colors.green : Themes.primaryColor,
          child: IconButton(
            onPressed: () {
              setState(() {});
              is_reviewed = !is_reviewed;
              _taskRef.update({'status': "completed"});
              _userTaskRef.update({'status': "completed"});
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ));
  }
}
