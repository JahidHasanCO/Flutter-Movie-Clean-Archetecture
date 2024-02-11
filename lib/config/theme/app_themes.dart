import 'package:flutter/material.dart';
import 'package:flutter_demo_app/config/colors/colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: Colors.blue,
  );
}

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.blue,
  );
}
