import 'package:flutter/material.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';
import 'package:frontend_wepay/utils/theme/appbar_theme.dart';


class AppTheme {
  AppTheme._();

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: TColors.kPrimaryColor,
    scaffoldBackgroundColor: TColors.kLightGrey,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: TColors.kPrimaryColor,
    scaffoldBackgroundColor: TColors.dark,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
  );
}