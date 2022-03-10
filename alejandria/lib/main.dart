import 'package:alejandria/screens/screens.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'tabs',
        routes: {
          'home': (_) => HomeScreen(),
          'login': (_) => LoginScreen(),
          'register': (_) => RegisterScreen(),
          'editProfile': (_) => EditProfileScreen(),
          'tabs': (_) => TabsScreen()
        },
        theme: AppTheme.lightTheme);
  }
}
