import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String userName;
  final Size size;
  final String imagePath;

  const PostHeader(this.userName, this.size, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: size.width * 0.6,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Preferences.isDarkMode
              ? Colors.black87
              : Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20), topLeft: Radius.circular(18)),
          border: Border.all(color: AppTheme.primary.withOpacity(0.7))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          onTap: () {
            if (userName.substring(1) != Preferences.userNick) {
              Navigator.pushNamed(context, 'otherUser',
                  arguments: {'nick': userName.substring(1)});
            }
          },
          child: Row(children: [
            Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/icon.png'),
                      image: NetworkImage(imagePath))),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              userName,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              width: 10,
            )
          ]),
        ),
      ),
    );
  }
}
