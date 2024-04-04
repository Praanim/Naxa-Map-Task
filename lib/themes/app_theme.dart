import 'package:flutter/material.dart';
import 'package:map_task/core/constants/constants.dart';

class AppTheme {
  static ThemeData defaultTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Constants.primaryColor,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Constants.secondaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: Constants.whiteColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: Constants.secondaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: Constants.secondaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: Constants.secondaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          // backgroundColor: LightColor.primaryColor,
          unselectedItemColor: Constants.secondaryColor,
          selectedItemColor: Constants.primaryColor,
          selectedLabelStyle: TextStyle(
              color: Constants.secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
            color: Constants.secondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
