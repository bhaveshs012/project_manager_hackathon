import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/projectScreen/assign_project_screen.dart';
import 'package:sizer/sizer.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({Key? key, required this.user}) : super(key: key);
  final Stream<QuerySnapshot> _projectStream =
      FirebaseFirestore.instance.collection('projects').snapshots();
  final MyUser user;
  final fbUser = FirebaseAuth.instance.currentUser;
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
                      backgroundImage:
                          NetworkImage(fbUser!.photoURL.toString()),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _projectStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: Themes.primaryColor));
                        } else if (snapshot.hasData) {
                          final List projectList = [];
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map a = document.data() as Map<String, dynamic>;
                            projectList.add(a);
                            a['id'] = document.id;
                          }).toList();
                          return ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: ProjectCard(
                                    user: user,
                                    project: Project(
                                        name: projectList[index]["name"],
                                        id: projectList[index]["id"],
                                        image: projectList[index]["image"],
                                        desc: projectList[index]["desc"]),
                                  ),
                                );
                              },
                              itemCount: projectList.length);
                        }
                        return Container();
                      }),
                ),
              ],
            ),
          )),
      floatingActionButton: Visibility(
        visible: user.is_admin == true ? true : false,
        child: FloatingActionButton(
          backgroundColor: Themes.primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(() => AssignProject(user: user));
          },
        ),
      ),
    );
  }
}

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
    return Container(
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
                    text: "12/20 tasks",
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
