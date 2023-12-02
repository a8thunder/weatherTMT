import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle textStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.questrial(
      color: color ?? Colors.white,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }
}
