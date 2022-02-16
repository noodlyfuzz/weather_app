import 'package:flutter/material.dart';

import 'package:weather_app/MainScreen/main_screen.dart';
import 'package:weather_app/Theme/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.mainAppBarColor,
        ),
        primarySwatch: Colors.green,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainAppBarColor,
        ),
      ),
      home: MainScreenWidget(),
    );
  }
}
