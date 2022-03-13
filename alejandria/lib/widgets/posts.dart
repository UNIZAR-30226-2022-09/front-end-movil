import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Post extends StatelessWidget {
  final int type;
  const Post({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            type == 0 ? _BackgroundImage(size) : _Recommendation(),
            Positioned(bottom: 0, right: 0, child: _Bottom()),
            Positioned(
                top: 0, left: 0, child: _Header('@nombreDeUsuario', size)),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.primary, width: 1),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _Header extends StatelessWidget {
  final String userName;
  final Size size;

  const _Header(this.userName, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.7,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Preferences.isDarkMode ? Colors.white10 : Colors.white54,
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

class _Bottom extends StatelessWidget {
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
      color: Preferences.isDarkMode ? Colors.white10 : Colors.white54,
      border: Border.all(color: AppTheme.primary.withOpacity(0.7)),
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(18), topLeft: Radius.circular(20)));
}

class _BackgroundImage extends StatelessWidget {
  final Size size;
  const _BackgroundImage(this.size);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Preferences.isDarkMode ? Colors.black87 : Colors.grey[400],
        width: size.width * 0.95,
        height: size.width * 1.34,
      ),
    );
  }
}

class _Recommendation extends StatelessWidget {
  const _Recommendation();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Preferences.isDarkMode ? Colors.black : Colors.grey[50],
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 70),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Título del Artículo - Autor',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Nulla tempor ipsum exercitation incididunt. Qui consectetur laborum anim incididunt. Cupidatat cillum incididunt tempor ipsum enim in aute dolore Lorem. ',
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: Text(
              'https://github.com/UNIZAR-30226-2022-09/front-end-movil',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Preferences.isDarkMode
                      ? Colors.blue[200]
                      : Colors.blue[900]),
            ),
            onTap: () async {
              launch("https://github.com/UNIZAR-30226-2022-09/front-end-movil");
            },
          )
        ]),
      ),
    );
  }
}
