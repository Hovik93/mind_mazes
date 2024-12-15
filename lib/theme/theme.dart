import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_mazes/base/colors.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  textTheme: TextTheme(
    bodySmall: TextStyle(
      color: AppColors.grey2,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      fontFamily: "SFProDisplay",
    ),
    bodyMedium: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 18.sp,
      fontFamily: "SFProDisplay",
    ),
    titleSmall: TextStyle(
      color: AppColors.grey1,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      fontFamily: "SFProDisplay",
    ),
    headlineLarge: TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w700,
      fontSize: 36.sp,
      fontFamily: "SFProDisplay",
    ),
  ),
);
