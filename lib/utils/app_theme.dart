import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class AppTheme {
  static ThemeData DarkTheme =ThemeData(
    scaffoldBackgroundColor: appColors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.amber),
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.amber)),
    iconTheme: IconThemeData(color: Colors.amber)
  );
}