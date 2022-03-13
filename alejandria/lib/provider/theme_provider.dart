import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;

  ThemeProvider({required bool isDarkmode})
      : currentTheme = isDarkmode ? AppTheme.darkTheme : AppTheme.lightTheme;

  setLightMode() {
    currentTheme = AppTheme.lightTheme;
    AppTheme.primary = Color.fromRGBO(68, 114, 88, 1);
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = AppTheme.darkTheme;
    AppTheme.primary = Color.fromRGBO(214, 155, 65, 1);
    notifyListeners();
  }
}
