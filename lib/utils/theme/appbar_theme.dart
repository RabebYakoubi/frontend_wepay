import 'package:flutter/material.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 1,
    centerTitle: true,
    scrolledUnderElevation: 1,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.darkGrey, size: 30),
    actionsIconTheme: IconThemeData(color: TColors.darkGrey, size: 30),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: TColors.textwhite,
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 1,
    centerTitle: true,
    scrolledUnderElevation: 1,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.darkGrey, size: 30),
    actionsIconTheme: IconThemeData(color: TColors.darkGrey, size: 30),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: TColors.textwhite,
    ),
  );
}