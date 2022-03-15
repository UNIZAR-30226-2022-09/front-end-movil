import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String userName;
  final Size size;

  const PostHeader(this.userName, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.7,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Preferences.isDarkMode
              ? Colors.white10
              : Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20), topLeft: Radius.circular(18)),
          border: Border.all(color: AppTheme.primary.withOpacity(0.7))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(children: [
          CircleAvatar(
            radius: 20,
          ),
          SizedBox(
            width: 7,
          ),
          Text(
            userName,
            style: TextStyle(fontSize: 17),
          )
        ]),
      ),
    );
  }
}
