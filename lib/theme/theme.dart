import 'package:flutter/material.dart';

import 'app_colors.dart';

AppBarTheme buildAppBarTheme() {
  return AppBarTheme(
    backgroundColor: AppColors.mainDarkBlue,
    brightness: Brightness.dark,
  );
}

BottomNavigationBarThemeData buildBottomNavigationBarThemeData() {
  return BottomNavigationBarThemeData(
    backgroundColor: AppColors.mainDarkBlue,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
  );
}