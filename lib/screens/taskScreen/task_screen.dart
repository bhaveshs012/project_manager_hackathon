import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/tasks.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/bottom_navbar.dart';
import 'package:project_manager_hackathon/screens/taskScreen/assign_task.dart';
import 'package:project_manager_hackathon/screens/taskScreen/widgets/priority_indicator.dart';
import 'package:project_manager_hackathon/screens/taskScreen/widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key? key, required this.user, required this.project})
      : super(key: key);
  final MyUser user;
  final Project project;
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    print("name is ${widget.user.name}");
    final Stream<QuerySnapshot> _taskStream = FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.project.id)
        .collection('tasks')
        .where('deadline', isGreaterThanOrEqualTo: _selectedDate)
        .snapshots();
    print(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () => Get.offAll(() =>
                MyCustomBottomNavbar(initailIndex: 0, user: widget.user)),
          color: Colors.black,
        ),
        title: const Text(
          'Tasks Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: _addDatePicker()),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "My Tasks",
                            style: title1Style,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Priority",
                                style: subtitlestyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              PriorityIndicator(
                                color: Themes.hPrioritySecondaryColor,
                                priority: "High",
                              ),
                              PriorityIndicator(
                                color: Themes.mPrioritySecondaryColor,
                                priority: "Medium",
                              ),
                              PriorityIndicator(
                                color: Themes.lPrioritySecondaryColor,
                                priority: "Low",
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: _taskStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: Themes.primaryColor));
                            } else if (snapshot.hasData) {
                              final List tasksList = [];
                              snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map a = document.data() as Map<String, dynamic>;
                                if (a["email"] == widget.user.email)
                                  tasksList.add(a);
                                a['id'] = document.id;
                              }).toList();
                              return ListView.builder(
                                  itemCount: tasksList.length,
                                  itemBuilder: ((context, index) {
                                    return TaskCard(
                                        tasks: Task(
                                          title: tasksList[index]["name"],
                                          desc: tasksList[index]["desc"],
                                          priority: tasksList[index]
                                              ["priority"],
                                          deadline: DateTime.parse(
                                              tasksList[index]["deadline"]
                                                  .toDate()
                                                  .toString()),
                                        ),
                                        user: widget.user);
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Themes.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          print("${widget.user.is_admin} nameee");
          Get.to(() => AssignTask(
            user: widget.user,
            project: widget.project,
          ));
        },
      ),
    );
  }

  DatePicker _addDatePicker() {
    return DatePicker(
      DateTime.now(),
      dateTextStyle: TextStyle(color: Themes.primaryColor, fontSize: 22),
      dayTextStyle: const TextStyle(color: Colors.black, fontSize: 15),
      monthTextStyle: const TextStyle(color: Colors.black, fontSize: 15),
      onDateChange: (selectedDate) {
        setState(() {
          _selectedDate = selectedDate;
        });
      },
      selectedTextColor: Colors.white,
      selectionColor: Themes.primaryColor,
      initialSelectedDate: DateTime.now(),
    );
  }
}

