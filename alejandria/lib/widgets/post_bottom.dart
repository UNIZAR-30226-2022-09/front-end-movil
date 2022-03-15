import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostBottom extends StatelessWidget {
  final bool isArticle;

  const PostBottom({Key? key, required this.isArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 60,
      width: 290,
      decoration: _buildBoxDecoration(),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Icon(FontAwesomeIcons.heart),
        SizedBox(
          width: 5,
        ),
        Text('200'),
        SizedBox(
          width: 20,
        ),
        Icon(FontAwesomeIcons.comment),
        SizedBox(
          width: 5,
        ),
        Text('38'),
        SizedBox(
          width: 20,
        ),
        Icon(FontAwesomeIcons.save),
        SizedBox(
          width: 5,
        ),
        Text('25'),
        SizedBox(
          width: 20,
        ),
        Icon(FontAwesomeIcons.shareAlt),
      ]),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Preferences.isDarkMode
          ? Colors.white10
          : Colors.white.withOpacity(0.85),
      border: Border.all(color: AppTheme.primary.withOpacity(0.7)),
      borderRadius: isArticle
          ? BorderRadius.only(topLeft: Radius.circular(20))
          : BorderRadius.only(
              bottomRight: Radius.circular(18), topLeft: Radius.circular(20)));
}
