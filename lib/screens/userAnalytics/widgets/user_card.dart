import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/taskScreen/task_screen.dart';
import 'package:sizer/sizer.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user,
    required this.completedTask,
    required this.onGoingTasks,
    required this.inReviewTasks,
  }) : super(key: key);
  final MyUser user;
  final int completedTask;
  final int onGoingTasks;
  final int inReviewTasks;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 2.h,
        ),
        height: 33.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage('assets/images/${Random().nextInt(4) + 1}.png'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name, style: title2Style),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                child: Text(user.post,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: subtitle1Style),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: Themes.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Text(
                  user.department,
                  style: subtitlestyle.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskStatus(
                    title: "Completed",
                    count: completedTask,
                  ),
                  TaskStatus(
                    title: "On Going",
                    count: onGoingTasks,
                  ),
                  TaskStatus(
                    title: "In Review",
                    count: inReviewTasks,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskStatus extends StatelessWidget {
  const TaskStatus({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$title : ",
        style: subtitlestyle,
        children: [
          TextSpan(
            text: count.toString(),
            style: subtitlestyle.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
