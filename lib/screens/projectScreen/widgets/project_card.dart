import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/taskScreen/task_screen.dart';
import 'package:sizer/sizer.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.user,
    required this.project,
  }) : super(key: key);
  final MyUser user;
  final Project project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TaskScreen(user: user, project: project));
      },
      child: Container(
        height: 20.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage('assets/images/${project.image}.png'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.name, style: title2Style),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                width: 60.w,
                child: Text(project.desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: subtitlestyle),
              ),
              SizedBox(
                height: 3.h,
              ),
              RichText(
                  text: TextSpan(
                      text:
                          "${project.taskCompleted}/${project.totalTasks} tasks",
                      style: subtitlestyle,
                      children: [
                    TextSpan(
                      text: "  ${((project.taskCompleted!/project.totalTasks) * 100).toInt()}%",
                      style: subtitlestyle.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
                    )
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
