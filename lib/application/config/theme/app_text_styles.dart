import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AppTextStyles on TextTheme {
  TextStyle get defaultBody => TextStyle(
        fontFamily: 'Galano Grotesque',
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        height: 1.35.sp,
        letterSpacing: 0.01.sp,
      );
  TextStyle get defaultCaption2 => TextStyle(
        fontFamily: 'Galano Grotesque',
        fontWeight: FontWeight.w600,
        fontSize: 11.sp,
        height: 1.35.sp,
        letterSpacing: 0.02.sp,
      );
  TextStyle get defaultTitle3 => TextStyle(
        fontFamily: 'Galano Grotesque',
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
        height: 1.35.sp,
        letterSpacing: 0.01.sp,
      );
  TextStyle get defaultHeadline => TextStyle(
        fontFamily: 'Galano Grotesque',
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        height: 1.33.sp,
        letterSpacing: 0.005.sp,
      );
  TextStyle get thinHeadline => TextStyle(
        fontFamily: 'Galano Grotesque',
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        height: 1.33.sp,
        letterSpacing: 0.005.sp,
      );
  TextStyle get thinFootnote => TextStyle(
        fontFamily: 'Galano Grotesque',
        fontWeight: FontWeight.w500,
        fontSize: 13.sp,
        height: 1.385.sp,
        letterSpacing: 0.01.sp,
      );
}
