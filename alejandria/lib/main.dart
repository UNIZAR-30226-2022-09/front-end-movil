import 'package:alejandria/provider/theme_provider.dart';
import 'package:alejandria/screens/screens.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkMode))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (_) => LoginScreen(),
          'register': (_) => RegisterScreen(),
          'editProfile': (_) => EditProfileScreen(),
          'tabs': (_) => TabsScreen(),
          'home': (_) => HomeScreen(),
          'explorer': (_) => ExplorerScreen(),
          'newPost': (_) => NewPostScreen(),
          'notifications': (_) => NotificationsScreen(),
          'profile': (_) => UserScreen()
        },
        theme: Provider.of<ThemeProvider>(context).currentTheme);
  }
}
