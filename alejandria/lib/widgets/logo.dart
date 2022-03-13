import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/no-background-icon.png'),
                width: 190,
              ),
              Text('ALEJANDRÍA',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Amazing Grotesc Ultra',
                      color: AppTheme.intro))
            ],
          )),
    );
  }
}
