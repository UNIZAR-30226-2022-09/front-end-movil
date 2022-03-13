import 'package:alejandria/share_preferences/preferences.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Preferences.isDarkMode
      ? Color.fromRGBO(214, 155, 65, 1)
      : Color.fromRGBO(68, 114, 88, 1);

  static Color intro = Color.fromRGBO(68, 114, 88, 1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    inputDecorationTheme: InputDecorationTheme(
        iconColor: Color.fromRGBO(68, 114, 88, 1),
        floatingLabelStyle: TextStyle(
            color: Color.fromRGBO(68, 114, 88, 1),
            fontSize: 20,
            fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(68, 114, 88, 1)),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(68, 114, 88, 1)),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(68, 114, 88, 1)),
            borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white54),
    //AppBar
    appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white12,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(68, 114, 88, 1))),
    //Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Color.fromRGBO(68, 114, 88, 1),
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      inputDecorationTheme: InputDecorationTheme(
          iconColor: Color.fromRGBO(214, 155, 65, 1),
          floatingLabelStyle: TextStyle(
              color: Color.fromRGBO(214, 155, 65, 1),
              fontSize: 20,
              fontWeight: FontWeight.w700),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(214, 155, 65, 1)),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(214, 155, 65, 1)),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(214, 155, 65, 1)),
              borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white70),
      //AppBar
      appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color.fromRGBO(214, 155, 65, 1))),
      //Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Color.fromRGBO(214, 155, 65, 1),
          unselectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed));
}
