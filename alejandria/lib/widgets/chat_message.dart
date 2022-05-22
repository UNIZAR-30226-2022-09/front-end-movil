import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class ChatMessage extends StatelessWidget {


  final String texto;
  final String nick;
  final AnimationController animationController; 

  const ChatMessage({
    Key? key, 
    required this.texto, 
    required this.nick,
    required this.animationController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: this.nick == Preferences.userNick
          ? _myMessage()
          : _notMyMessage(),
          
        ),
      ),
    );
  }

  Widget _myMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          right: 5,
          left: 50
        ),
        child: Text(this.texto, style: TextStyle(color: Preferences.isDarkMode
            ? AppTheme.dark
            : Colors.black87)),
        decoration: BoxDecoration(
          color: Preferences.isDarkMode ? Colors.white : Color(0xffe4e5e8),
          borderRadius: BorderRadius.circular(20)
        ),
      )
    );
  }

  Widget _notMyMessage(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          right: 50,
          left: 5
        ),
        child: Text(this.texto, style: TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(20)
        ),
      )
    );
  }
}