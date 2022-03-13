import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Article extends StatelessWidget {
  const Article({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: size.width * 0.95,
        height: size.width * 1.34,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(),
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
          color: Colors.white54,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20), topLeft: Radius.circular(18)),
          border: Border.all(color: AppTheme.primary.withOpacity(0.5))),
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
      color: Colors.white54,
      border: Border.all(color: AppTheme.primary.withOpacity(0.5)),
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(18), topLeft: Radius.circular(20)));
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
      ),
    );
  }
}
