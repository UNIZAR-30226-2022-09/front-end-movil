import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _isDarKmode = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode {
    return _prefs.getBool('isDarkmode') ?? _isDarKmode;
  }

  static set isDarkMode(bool value) {
    _isDarKmode = value;
    _prefs.setBool('isDarkmode', value);
  }
}
