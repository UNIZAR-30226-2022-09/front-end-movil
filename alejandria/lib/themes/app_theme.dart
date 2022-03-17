import 'package:alejandria/share_preferences/preferences.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color intro = Color.fromRGBO(68, 114, 88, 1);
  static Color light = Color.fromRGBO(68, 114, 88, 1);
  static Color dark = Color.fromRGBO(214, 155, 65, 1);

  static Color primary = Preferences.isDarkMode ? dark : light;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      inputDecorationTheme: InputDecorationTheme(
          iconColor: light,
          floatingLabelStyle: TextStyle(
              color: light, fontSize: 20, fontWeight: FontWeight.w400),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: light),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: light),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: light),
              borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white54),
      //AppBar
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white12,
          centerTitle: true,
          iconTheme: IconThemeData(color: light)),
      //Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: light,
          unselectedItemColor: Colors.black54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed),
      //Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(light),
      ));

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    inputDecorationTheme: InputDecorationTheme(
        iconColor: dark,
        floatingLabelStyle:
            TextStyle(color: dark, fontSize: 20, fontWeight: FontWeight.w700),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: dark),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: dark),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: dark),
            borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white24),
    //AppBar
    appBarTheme: AppBarTheme(
        elevation: 0, centerTitle: true, iconTheme: IconThemeData(color: dark)),
    //Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: dark,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed),
    //Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(dark),
    ),
  );
}
