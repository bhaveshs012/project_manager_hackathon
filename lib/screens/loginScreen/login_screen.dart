import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/screens/loginScreen/widgets/login_button.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 5.w),
          child: Column(
            children: [
              Image(
                image: const AssetImage("assets/logo.png"),
                height: 60.h,
                width: 80.w,
              ),
              Text(
                'Welcome to Project Manager',
                textAlign: TextAlign.center,
                style: title1Style,
              ),
              SizedBox(
                height: 7.h,
              ),
             LoginButton(),
            ],
          ),
        ));
  }
}