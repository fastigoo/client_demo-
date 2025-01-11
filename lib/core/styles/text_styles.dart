import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/core/styles/main_colors.dart';

class TextStyles {
  static TextStyle smallBodyTextStyle(BuildContext context) =>
      GoogleFonts.roboto(
        fontSize: 13.sp,
        color: MainColors.textColor(context),
      );
  static TextStyle mediumBodyTextStyle(BuildContext context) =>
      GoogleFonts.roboto(
        fontSize: 15.sp,
        color: MainColors.textColor(context),
      );
  //create another styles here
  static TextStyle largeBodyTextStyle(BuildContext context) =>
      GoogleFonts.roboto(
        fontSize: 17.sp,
        color: MainColors.textColor(context),
      );

  static TextStyle buttonTextStyle(BuildContext context) => GoogleFonts.roboto(
        fontSize: 15.sp,
        color: MainColors.textColor(context),
      );

  static TextStyle smallLabelTextStyle(BuildContext context) =>
      GoogleFonts.fredoka(
        height: 1.72,
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      );

  static TextStyle mediumLabelTextStyle(BuildContext context) =>
      GoogleFonts.fredoka(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      );

  static TextStyle largeLabelTextStyle(BuildContext context) =>
      GoogleFonts.fredoka(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      );
}
