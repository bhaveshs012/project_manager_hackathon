import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23.0),
          ),
        ),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
        backgroundColor:
            MaterialStateProperty.all(Themes.primaryColor), // <-- Button color
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.pressed))
              return Colors.blueAccent; // <-- Splash color
          },
        ),
      ),
    );
  }
}