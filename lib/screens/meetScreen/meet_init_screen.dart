import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/screens/meetScreen/create_meet.dart';
import 'package:project_manager_hackathon/screens/meetScreen/join_meet.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/style_button.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/top_row.dart';

class MeetScreen extends StatelessWidget {
  const MeetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              TopRow(
                title: "Virtual Meet",
                style: title1Style,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StyledButton(
                    title: "Create a Meeting",
                    onTap: () {
                      Get.to(CreateMeet());
                    },
                  ),
                  StyledButton(
                    title: "Join a Meeting",
                    onTap: () {
                      Get.to(JoinMeet());
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset("assets/images/meet-logo.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
