import 'package:flutter/material.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';
import 'package:frontend_wepay/utils/theme/appbar_theme.dart';
import 'package:frontend_wepay/utils/theme/bottom_sheet_theme.dart';
import 'package:frontend_wepay/utils/theme/dialog_theme.dart';
import 'package:frontend_wepay/utils/theme/elevated_button_theme.dart';
import 'package:frontend_wepay/utils/theme/outlined_button_theme.dart';
import 'package:frontend_wepay/utils/theme/text_button_theme.dart';
import 'package:frontend_wepay/utils/theme/text_theme.dart';
import 'package:frontend_wepay/utils/theme/textformfield_theme.dart';


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
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    dialogTheme: TDialogTheme.lightDialogTheme,
    textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: TColors.kPrimaryColor,
    scaffoldBackgroundColor: TColors.dark,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    dialogTheme: TDialogTheme.darkDialogTheme,
    textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
  );
}