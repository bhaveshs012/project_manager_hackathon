import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/tasks.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/taskScreen/task_details_screen.dart';
import 'package:sizer/sizer.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {Key? key,
      required this.tasks,
      required this.user,
      required this.project})
      : super(key: key);
  final Task tasks;
  final MyUser user;
  final Project project;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          TaskDetailsScreen(
            tasks: tasks,
            project: project,
            user: user,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.h),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: tasks.priority == "high"
              ? Themes.hPriorityPrimaryColor
              : tasks.priority == "medium"
                  ? Themes.mPriorityPrimaryColor
                  : Themes.lPriorityPrimaryColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              width: 8,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: tasks.priority == "high"
                    ? Themes.hPrioritySecondaryColor
                    : tasks.priority == "medium"
                        ? Themes.mPrioritySecondaryColor
                        : Themes.lPrioritySecondaryColor,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tasks.title,
                          style: subtitlestyle.copyWith(
                              color: tasks.priority == "high"
                                  ? Themes.hPrioritySecondaryColor
                                  : tasks.priority == "medium"
                                      ? Themes.mPrioritySecondaryColor
                                      : Themes.lPrioritySecondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.black38,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${DateFormat('dd-MM-yyyy').format(tasks.deadline)}",
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Text(
                          tasks.desc,
                          overflow: TextOverflow.ellipsis,
                          style: subtitlestyle,
                        ),
                      ),
                      Text(
                        tasks.status.toString().capitalize.toString(),
                        style:
                            subtitlestyle.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
