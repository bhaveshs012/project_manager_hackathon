import 'package:flutter/material.dart';

class TopRow extends StatelessWidget {
  TopRow({Key? key, required this.title, required this.style})
      : super(key: key);
  final String title;
  TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: style);
  }
}
