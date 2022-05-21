import 'package:flutter/material.dart';

import 'package:alejandria/provider/tematicas_provider.dart';
import 'package:alejandria/provider/theme_provider.dart';
import 'package:alejandria/screens/other_user_screen.dart';
import 'package:alejandria/screens/screens.dart';
import 'package:alejandria/screens/una_prueba.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthService()),
    ChangeNotifierProvider(create: (_) => UserService()),
    ChangeNotifierProvider(create: (_) => MyPostsService()),
    ChangeNotifierProvider(create: (_) => PostService()),
    ChangeNotifierProvider(create: (_) => PruebaProvider()),
    ChangeNotifierProvider(create: (_) => ComentariosService()),
    ChangeNotifierProvider(
        create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkMode)),
    ChangeNotifierProvider(create: (_) => TematicasProvider()),
    ChangeNotifierProvider(create: ( _ ) => SocketService()),
    ChangeNotifierProvider(create: ( _ ) => ChatService()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'chek', //cambiar ruta ainicial a check
        routes: {
          'chek': (_) => CheckAuthScreen(),
          'login': (_) => LoginScreen(),
          'editProfile': (_) => EditProfileScreen(),
          'tabs': (_) => TabsScreen(),
          'home': (_) => HomeScreen(),
          'explorer': (_) => ExplorerScreen(),
          'newPost': (_) => NewPostScreen(),
          'newArticle': (_) => NewArticleScreen(),
          'newRecoommendation': (_) => NewRecommendationScreen(),
          'notifications': (_) => NotificationsScreen(),
          'profile': (_) => UserScreen(),
          'savedPosts': (_) => SavedPostsScreen(),
          'loading': (_) => LoadingScreen(),
          'onePost': (_) => OnePostScreen(),
          'comentarios': (_) => CommentsScreen(),
          'pdfScreen': (_) => PDFScreen(),
          'otherUser': (context) => OtherUserScreen(ModalRoute.of(context)!
              .settings
              .arguments as Map<String, dynamic>),
          'chatList': (_) => ChatListScreen(),
          'chat': (_) => ChatScreen()
        },
        scaffoldMessengerKey: NotificationsService.messengerKey,
        theme: Provider.of<ThemeProvider>(context).currentTheme);
  }
}
