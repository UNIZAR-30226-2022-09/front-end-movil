import 'package:alejandria/screens/screens.dart';
import 'package:alejandria/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>( context );
    return Scaffold(
        body: Center(
      child: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) return Container();

          //No estoy autentificado
          if (snapshot.data == '') {
            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => LoginScreen(),
                      transitionDuration: Duration(seconds: 0)));
            });
          }
          //Estoy autentificado
          else {
            Future.microtask(() {
              socketService.connect();
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => TabsScreen(),
                      transitionDuration: Duration(seconds: 0)));
            });
          }

          return Container();
        },
      ),
    ));
  }
}
