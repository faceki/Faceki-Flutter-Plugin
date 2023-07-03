import 'package:fackikyc/constant1/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle bold({
    double? height,
    Color color = Colors.black,
    bool isUnderline = false,
    double fontSize = 15,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
      height: height,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle medium({
    double? height,
    Color color = Colors.black,
    bool isUnderline = false,
    double fontSize = 15,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
      height: height,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle regular({
    double? height,
    double? letterSpacing,
    Color color = Colors.black,
    bool isUnderline = false,
    double fontSize = 15,
  }) {
    return GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color,
        height: height,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: letterSpacing);
  }

 static TextStyle regularColor({
    double? height,
    double? letterSpacing,
    Color? color,
    bool isUnderline = false,
    double fontSize = 15,
  }) {
    return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        color: color??AppColors.primaryColor,
        height: height,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: letterSpacing);
  }
  static TextStyle semiBold({
    double? height,
    Color color = Colors.black,
    bool isUnderline = false,
    double fontSize = 15,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
      height: height,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }
}