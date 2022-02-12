import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/bottom_navbar.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/input_field.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/style_button.dart';

class AssignProject extends StatefulWidget {
  const AssignProject({Key? key, required this.user}) : super(key: key);
  final MyUser user;
  @override
  _AssignProjectState createState() => _AssignProjectState();
}

class _AssignProjectState extends State<AssignProject> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectDescController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final CollectionReference _projectReference =
        FirebaseFirestore.instance.collection('projects');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Project",
          style: title2Style,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 40,
          ),
          onPressed: () => Get.offAll(
              () => MyCustomBottomNavbar(initailIndex: 0, user: widget.user)),
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: padding,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MyInputField(
              title: "Title",
              hint: 'Enter Title',
              controller: _projectNameController,
            ),
            MyInputField(
              title: "Description",
              hint: 'Enter Description',
              controller: _projectDescController,
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
                child: StyledButton(
              title: "Creaste project",
              onTap: () {
                _projectReference.add({
                  "name": _projectNameController.text,
                  "desc": _projectDescController.text,
                  "image": Random().nextInt(3) + 1,
                }).then((value) {
                  Get.off(() => MyCustomBottomNavbar(
                        initailIndex: 0,
                        user: widget.user,
                      ));
                });
              },
            ))
          ]),
        ),
      ),
    );
  }
}
