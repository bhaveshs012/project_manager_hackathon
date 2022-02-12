import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/tasks.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/style_button.dart';
import 'package:sizer/sizer.dart';

class AllTaskDetailScreen extends StatelessWidget {
  const AllTaskDetailScreen(
      {Key? key, required this.tasks, required this.project})
      : super(key: key);
  final Task tasks;
  final Project project;
  @override
  Widget build(BuildContext context) {
    DocumentReference taskRef = FirebaseFirestore.instance
        .collection("projects")
        .doc(project.id)
        .collection("tasks")
        .doc(tasks.id);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(tasks.title, style: title1Style),
                ),
                SizedBox(height: 3.h),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 5),
                  child: Text(
                    tasks.desc,
                    style: subtitlestyle,
                  ),
                ),
                SizedBox(height: 3.h),
                RichText(
                  text: TextSpan(
                    text: "Priority: ",
                    style: title2Style,
                    children: [
                      TextSpan(
                        text: "${tasks.priority}".toUpperCase(),
                        style: subtitlestyle.copyWith(
                            color: tasks.priority == "high"
                                ? Themes.hPrioritySecondaryColor
                                : tasks.priority == "medium"
                                    ? Themes.mPrioritySecondaryColor
                                    : Themes.lPrioritySecondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                RichText(
                  text: TextSpan(
                    text: "Start Date: ",
                    style: title2Style,
                    children: [
                      TextSpan(
                        text:
                            "${DateFormat('dd-MM-yyyy').format(tasks.startDate)}",
                        style: subtitlestyle.copyWith(
                            color: Themes.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                RichText(
                  text: TextSpan(
                    text: "Deadline: ",
                    style: title2Style,
                    children: [
                      TextSpan(
                        text:
                            "${DateFormat('dd-MM-yyyy').format(tasks.deadline)}",
                        style: subtitlestyle.copyWith(
                            color: Themes.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Center(
                  child: StyledButton(
                      title: "Mark as Reviewed",
                      onTap: () {
                        taskRef.update({
                          'status': 'in_review',
                        });
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
