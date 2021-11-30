import 'package:flutter/material.dart';

class GeneralInfos {
  static int getUserLoginId() {
    return 1;
  }
}

class ColorsApplication {
  static var primaryColor = Color(0xff121212);
  static var greenColor = Colors.cyan.shade100; //Color(0xffB8FFC4);
  static var themeMaterialApplication = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),
    primaryColor: ColorsApplication.primaryColor,
    // accentColor: ColorsApplication.greenColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black.withOpacity(0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white70),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorsApplication.greenColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorsApplication.greenColor),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorsApplication.greenColor,
      shape: RoundedRectangleBorder(),
    ),
  );
}
