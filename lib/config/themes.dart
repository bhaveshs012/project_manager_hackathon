import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static const lPriorityPrimaryColor = Color(0xffEDF9F5);
  static const lPrioritySecondaryColor = Color.fromRGBO(72, 177, 78, 1);
  static const hPriorityPrimaryColor = Color(0xffFBF4F9);
  static const hPrioritySecondaryColor = Color(0xffDC5B57);
  static const mPriorityPrimaryColor = Color.fromARGB(255, 252, 247, 235);
  static const mPrioritySecondaryColor = Color(0xffFDBF0B);
  static const primaryColor = Color(0xff3972F2);
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
  );
}
TextStyle get subtitlestyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
  );
}