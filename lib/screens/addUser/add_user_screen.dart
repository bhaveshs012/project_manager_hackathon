import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/bottom_navbar.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/input_field.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/style_button.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  DateTime _selectedDate = DateTime.now();
  List<String> usersList = ["vishesh", "bhavesh", "rohit", "dhruv", "shubham"];
  List<String> departmentList = ["Tech", "Design", "HR", "Marketing", "Sales"];
  final String _selectedUser = "Select User";
  String _selectedDepartment = "Select Department";
  bool? _isAdmin = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _postController = TextEditingController();
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("users");
  late MyUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Profile",
                  style: title1Style,
                ),
                MyInputField(
                  title: "Name",
                  hint: 'Enter Name',
                  controller: _nameController,
                ),
                MyInputField(
                  title: "Enter Department",
                  hint: _selectedDepartment,
                  widget: DropdownButton(
                    onChanged: ((value) => setState(() {
                          _selectedDepartment = value.toString();
                        })),
                    items: departmentList
                        .map<DropdownMenuItem<String>>((String department) {
                      return DropdownMenuItem<String>(
                        value: department,
                        child: Text(department),
                      );
                    }).toList(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitlestyle,
                  ),
                ),
                MyInputField(
                  title: "Post",
                  hint: 'Enter Post',
                  controller: _postController,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    "Are you admin?",
                    style: subtitlestyle,
                  ),
                  value: _isAdmin,
                  onChanged: (value) {
                    setState(
                      () {
                        _isAdmin = value;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: StyledButton(
                    title: "Submit",
                    onTap: () {
                      if (_nameController.text.isEmpty ||
                          _postController.text.isEmpty) {
                        Get.snackbar("Error", "Please fill all the fields",
                            backgroundColor:
                                Themes.primaryColor.withOpacity(0.5),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            isDismissible: true);
                      } else {
                        _userReference.add({
                          "name": _nameController.text,
                          "post": _postController.text,
                          "department": _selectedDepartment,
                          "is_admin": _isAdmin,
                          "email": FirebaseAuth.instance.currentUser!.email,
                        }).then((value) {
                          user = MyUser(
                              id: value.id,
                              name: _nameController.text,
                              department: _selectedDepartment,
                              email: FirebaseAuth.instance.currentUser!.email
                                  .toString(),
                              post: _postController.text,
                              is_admin: _isAdmin);
                          Get.to(() => MyCustomBottomNavbar(
                                initailIndex: 0,
                                user: user,
                              ));
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2023),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }
}
