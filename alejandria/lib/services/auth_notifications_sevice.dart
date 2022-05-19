import 'package:alejandria/share_preferences/preferences.dart';
import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = new SnackBar(
      backgroundColor: Preferences.isDarkMode
          ? Colors.grey.withOpacity(0.9)
          : Colors.black.withOpacity(0.9),
      content:
          Text(message, style: TextStyle(color: Colors.white, fontSize: 20)),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
