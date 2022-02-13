import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:sizer/sizer.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(60),
      child: Column(
        children: [
          Flexible(
            child: Image.asset(
              "assets/images/on_board/onboard_2.png",
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: title2Style,
            ),
          ),
        ],
      ),
    );
  }
}
