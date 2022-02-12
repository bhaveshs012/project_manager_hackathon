import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:sizer/sizer.dart';

class projectScreen extends StatelessWidget {
  const projectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: padding,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hello, Vishesh', style: title2Style),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              ProjectCard(
                title: "Project 01",
                desc: "This project aims to ensure hardware safety",
                totaltasks: 20,
                tasksCompleted: 12,
                imageNo: Random().nextInt(3) + 1,
              ),
              SizedBox(
                height: 3.h,
              ),
              ProjectCard(
                title: "Project 02",
                desc: "This project aims to ensure software safety",
                totaltasks: 10,
                tasksCompleted: 20,
                  imageNo: Random().nextInt(3) + 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.title,
    required this.desc,
    required this.tasksCompleted,
    required this.totaltasks, required this.imageNo,
  }) : super(key: key);
  final String title;
  final String desc;
  final int tasksCompleted;
  final int totaltasks;
  final int imageNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: AssetImage('assets/images/$imageNo.png'), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: title2Style),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: 60.w,
              child: Text(desc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: subtitlestyle),
            ),
            SizedBox(
              height: 3.h,
            ),
            RichText(
                text: TextSpan(
                    text: "$tasksCompleted/$totaltasks tasks",
                    style: subtitlestyle,
                    children: [
                  TextSpan(
                    text: "  70%",
                    style: subtitlestyle.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
