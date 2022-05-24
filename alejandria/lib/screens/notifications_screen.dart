import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notificaciones',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary)),
          bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
        ),
        body: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              String message;
              if (index % 4 == 0)
                message = ' ha comentado en tu publicación.';
              else if (index % 2 == 0)
                message = ' ha comenzado a seguirte.';
              else
                message = ' le ha dado me gusta a tu publicación.';
              return Container(
                  margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.primary),
                      borderRadius: BorderRadius.circular(10),
                      color: Preferences.isDarkMode
                          ? Colors.black54
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: AppTheme.primary.withOpacity(0.1),
                            offset: Offset(0, 5),
                            blurRadius: 7)
                      ]),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          print('CLick en foto');
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          print('Click en texto');
                        },
                        child: _Message(
                          message: message,
                        ),
                      )
                    ],
                  ));
            }));
  }
}

class _Message extends StatelessWidget {
  final String message;
  const _Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 90,
      child: RichText(
        maxLines: 2,
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.5,
            color: Preferences.isDarkMode ? Colors.white : Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
                text: '@nombreDeUsuario',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: message),
          ],
        ),
      ),
    );
  }
}
