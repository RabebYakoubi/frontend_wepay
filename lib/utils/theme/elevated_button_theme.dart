// Light & Dark Elevated Button Themes
import 'package:flutter/material.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';


class TElevatedButtonTheme {
  TElevatedButtonTheme._();
  // Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: TColors.white,
      backgroundColor: TColors.buttonPrimary,
      disabledForegroundColor: TColors.textwhite,
      disabledBackgroundColor: TColors.buttonDisabled,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 75),
      textStyle: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: TColors.textwhite,
      ),
    ),
  );

  // Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: TColors.white,
      backgroundColor: TColors.buttonPrimary,
      disabledForegroundColor: TColors.textwhite,
      disabledBackgroundColor: TColors.buttonDisabled,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 75),
      textStyle: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: TColors.textwhite,
      ),
    ),
  );
}
/* const SizedBox(height: 10),
                        Align(
                          child: ElevatedButton(
                              onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                  print("Success");
                                } else {
                                  print("Failure");
                                }
                              },
                                style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50), // Largeur étendue
                                ),
                              child:  Text(
                                "Log In",
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.light),
                              ),
                            ),
                        ),
*/