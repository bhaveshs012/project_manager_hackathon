import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:sizer/sizer.dart';

class MyInputField extends StatelessWidget {
  const MyInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subtitlestyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            height: 62,
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.black45, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Themes.primaryColor,
                    controller: controller,
                    style: subtitlestyle.copyWith(color: Colors.black54),
                    decoration: InputDecoration(
                        labelText: hint,
                        enabled: widget == null ? true : false,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.3, color: Colors.black45),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Themes.primaryColor),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: Container(
                          child: widget,
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
