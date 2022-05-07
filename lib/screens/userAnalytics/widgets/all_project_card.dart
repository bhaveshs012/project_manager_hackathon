import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/screens/userAnalytics/widgets/all_tasks.dart';
import 'package:sizer/sizer.dart';

class AllProjectsCard extends StatelessWidget {
   AllProjectsCard({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    print(project.taskCompleted);
    print(project.totalTasks);
    return GestureDetector(
      onTap: () {
       Get.to(() => AllTasks(project: project,));
      },
      child: Container(
        height: 22.h,
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
                  text: "${project.taskCompleted}/${project.totalTasks} tasks",
                  style: subtitlestyle,
                  children: [
                    TextSpan(
                      text: project.totalTasks != 0
                          ? "  ${((project.taskCompleted / project.totalTasks) * 100).toInt()}%"
                          : "  0%",
                      style: subtitlestyle.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
