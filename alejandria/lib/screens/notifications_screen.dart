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
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary)),
        bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
      ),
      body: Center(
        child: Text('NotificationsScreen'),
      ),
    );
  }
}
