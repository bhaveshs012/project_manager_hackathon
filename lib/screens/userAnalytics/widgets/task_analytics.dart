import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/projectScreen/create_project_screen.dart';
import 'package:project_manager_hackathon/screens/projectScreen/widgets/project_card.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/top_row.dart';
import 'package:project_manager_hackathon/screens/userAnalytics/widgets/all_project_card.dart';
import 'package:sizer/sizer.dart';

class TaskAnalysis extends StatelessWidget {
  TaskAnalysis({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _projectStream =
      FirebaseFirestore.instance.collection('projects').snapshots();
  Future<int> _getTotalTasks(String id) async {
    QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('projects')
        .doc(id)
        .collection("tasks")
        .get();
    if (qSnap.docs.isEmpty) return 0;
    return qSnap.docs.length;
  }

  Future<int> _getTasksDone(String id) async {
    QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('projects')
        .doc(id)
        .collection("tasks")
        .where("status", isEqualTo: "completed")
        .get();
    if (qSnap.docs.isEmpty) return 0;
    return qSnap.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: padding,
          child: SafeArea(
            child: Column(
              children: [
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
                                return FutureBuilder(
                                    future: Future.wait([
                                      _getTotalTasks(projectList[index]['id']),
                                      _getTasksDone(projectList[index]['id']),
                                    ]),
                                    builder: (context,
                                        AsyncSnapshot<List<dynamic>> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                                color: Themes.primaryColor));
                                      } else if (snapshot.hasData) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: AllProjectsCard(
                                            project: Project(
                                                name: projectList[index]
                                                    ["name"],
                                                id: projectList[index]["id"],
                                                image: projectList[index]
                                                    ["image"],
                                                desc: projectList[index]
                                                    ["desc"],
                                                totalTasks: snapshot.data![0],
                                                taskCompleted:
                                                    snapshot.data![1]),
                                          ),
                                        );
                                      }
                                      return Container();
                                    });
                              },
                              itemCount: projectList.length);
                        }
                        return Container();
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
