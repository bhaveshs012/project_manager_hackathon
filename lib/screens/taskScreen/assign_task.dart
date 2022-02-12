import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/projects.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/input_field.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/style_button.dart';
import 'package:project_manager_hackathon/screens/taskScreen/task_screen.dart';

class AssignTask extends StatefulWidget {
  const AssignTask({Key? key, required this.user, required this.project})
      : super(key: key);
  final MyUser user;
  final Project project;
  @override
  _AssignTaskState createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  DateTime _selectedDate = DateTime.now();
  List<Map<String, String>> usersList = [];
  String? _selectedUser = "Select User";
  List<String> priorityList = ["high", "medium", "low"];
  String _selectedPriority = "Select Priority";
  String? _selectedId = "Select email";

  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  _getUsers() {
    _userReference.get().then((value) {
      List<Map<String, String>> users = [];
      for (var element in value.docs) {
        users.add({"name": element['name'], "id": element.id});
      }
      setState(() {
        usersList = users;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference _userTaskReference = FirebaseFirestore.instance
        .collection('users')
        .doc(_selectedId)
        .collection('tasks');
    final CollectionReference _taskReference = FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.project.id)
        .collection('tasks');
    print(widget.user.name);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 40,
          ),
          onPressed: () => Get.back(),
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assign Task",
                style: title1Style,
              ),
              MyInputField(
                title: "Title",
                hint: 'Enter Title',
                controller: _taskNameController,
              ),
              MyInputField(
                title: "Description",
                hint: 'Enter Description',
                controller: _taskDescriptionController,
              ),
              MyInputField(
                title: "Deadline:",
                hint: DateFormat('dd-MM-yyyy').format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.black38,
                  ),
                ),
              ),
              MyInputField(
                title: "Set priority:",
                hint: _selectedPriority.capitalizeFirst.toString(),
                widget: DropdownButton(
                  onChanged: ((value) => setState(() {
                        _selectedPriority = value.toString().toLowerCase();
                      })),
                  items: priorityList
                      .map<DropdownMenuItem<String>>((String priority) {
                    return DropdownMenuItem<String>(
                      value: priority,
                      child: Text(priority.capitalizeFirst.toString()),
                    );
                  }).toList(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitlestyle,
                ),
              ),
              MyInputField(
                title: "Assign to:",
                hint: _selectedUser.toString(),
                widget: DropdownButton(
                  onChanged: ((value) => setState(() {
                        for (var element in usersList) {
                          if (element["id"] == value.toString()) {
                            _selectedId = element["id"];
                            _selectedUser = element["name"];
                          }
                        }
                      })),
                  items: usersList.map<DropdownMenuItem<String>>((user) {
                    return DropdownMenuItem<String>(
                      value: user["id"],
                      child: Text(user['name'].toString()),
                    );
                  }).toList(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitlestyle,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: StyledButton(
                  title: "Assign Task",
                  onTap: () {
                 _userTaskReference.add({
                      "name": _taskNameController.text,
                      "desc": _taskDescriptionController.text,
                      "deadline": _selectedDate,
                      "priority": _selectedPriority,
                      "start_date": DateTime.now(),
                      "user_id": _selectedId,
                      "status": "ongoing",
                    }).then((id) {
                      _taskReference.add({
                        "user_task_id": id.id,
                        "name": _taskNameController.text,
                        "desc": _taskDescriptionController.text,
                        "deadline": _selectedDate,
                        "priority": _selectedPriority,
                        "start_date": DateTime.now(),
                        "user_id": _selectedId,
                        "status": "ongoing",
                      }).then(
                        (value) {
                          Get.offAll(
                            TaskScreen(
                              user: widget.user,
                              project: widget.project,
                            ),
                          );
                        },
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }
}
