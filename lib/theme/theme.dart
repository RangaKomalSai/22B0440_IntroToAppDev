import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();

  static ThemeData lightThemeData = ThemeData(
      brightness: Brightness.light,
      fontFamily: 'NotoSans',
      scaffoldBackgroundColor: const Color.fromRGBO(222, 222, 222,1)
  );


  static ThemeData darkThemeData = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'NotoSans',
  );
}