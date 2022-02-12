import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/style_button.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  ButtonWidget({
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) =>
      StyledButton(title: text, onTap: onClicked);
}
