import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/tasks.dart';
import 'package:project_manager_hackathon/screens/userAnalytics/widgets/all_task_card.dart';

class AllTasks extends StatelessWidget {
  AllTasks({Key? key, required this.project}) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _taskStream = FirebaseFirestore.instance
        .collection('projects')
        .doc(project.id)
        .collection('tasks')
        .where("status", isEqualTo: "in_review")
        .snapshots();
    return Scaffold(
        body: Padding(
      padding: padding,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _taskStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: Themes.primaryColor));
                  } else if (snapshot.hasData) {
                    print(snapshot.data!.docs.length);
                    final List tasksList = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      tasksList.add(a);
                      a['id'] = document.id;
                    }).toList();
                    return ListView.builder(
                        itemCount: tasksList.length,
                        itemBuilder: ((context, index) {
                          return AllTaskCard(
                            project: project,
                            tasks: Task(
                              status: tasksList[index]['status'],
                               user_id: tasksList[index]['user_id'],
                              user_task_id: tasksList[index]['user_task_id'],
                              id: tasksList[index]['id'],
                              title: tasksList[index]["name"],
                              desc: tasksList[index]["desc"],
                              priority: tasksList[index]["priority"],
                              deadline: DateTime.parse(tasksList[index]
                                      ["deadline"]
                                  .toDate()
                                  .toString()),
                              startDate: DateTime.parse(tasksList[index]
                                      ["start_date"]
                                  .toDate()
                                  .toString()),
                            ),
                          );
                        }));
                  } else {
                    return const Center(
                      child: Text("No Tasks"),
                    );
                  }
                }),
          ),
        ],
      ),
    ));
  }
}
