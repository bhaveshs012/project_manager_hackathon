import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Themes {
  static const lPriorityPrimaryColor = Color(0xffEDF9F5);
  static const lPrioritySecondaryColor = Color.fromRGBO(72, 177, 78, 1);
  static const hPriorityPrimaryColor = Color(0xffFBF4F9);
  static const hPrioritySecondaryColor = Color(0xffDC5B57);
  static const mPriorityPrimaryColor = Color.fromARGB(255, 252, 247, 235);
  static const mPrioritySecondaryColor = Color(0xffFDBF0B);
  static const primaryColor = Color(0xff3972F2);
}

TextStyle get title1Style {
  return GoogleFonts.raleway(
    textStyle: TextStyle(
        fontSize: 25.sp, fontWeight: FontWeight.bold, color: Colors.black),
  );
}

TextStyle get title2Style {
  return GoogleFonts.raleway(
    textStyle: TextStyle(
        fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
  );
}

TextStyle get subtitlestyle {
  return GoogleFonts.raleway(
    textStyle: TextStyle(
        fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.black),
  );
}

TextStyle get subtitle1Style {
  return GoogleFonts.raleway(
    textStyle: TextStyle(
        fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
  );
}

EdgeInsetsGeometry get padding {
  return EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h);
}
