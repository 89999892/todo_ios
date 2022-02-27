import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      backgroundColor: white,
  canvasColor: white,
  accentColor: white,
   brightness: Brightness.light
  );
  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      backgroundColor: darkHeaderClr,
    brightness: Brightness.dark
  );

  TextStyle get headingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 24, color: Get.isDarkMode ? white : darkGreyClr,fontWeight: FontWeight.bold));
  }
  TextStyle get subheadingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 20, color: Get.isDarkMode ? white : darkGreyClr,fontWeight: FontWeight.bold));
  }
  TextStyle get titleStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 18, color: Get.isDarkMode ? white : darkGreyClr,fontWeight: FontWeight.bold));
  }
  TextStyle get subTitleStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 16, color: Get.isDarkMode ? white : darkGreyClr,fontWeight: FontWeight.w400));
  }
  TextStyle get body1Style {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 14, color: Get.isDarkMode ? white : darkGreyClr,fontWeight: FontWeight.w400));
  }
  TextStyle get body2Style {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 14, color: Get.isDarkMode ? Colors.grey[200] : darkGreyClr,fontWeight: FontWeight.w400));
  }
}
