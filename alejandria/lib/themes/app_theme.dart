import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromRGBO(68, 114, 88, 1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      inputDecorationTheme: InputDecorationTheme(
          iconColor: primary,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white54));
}
