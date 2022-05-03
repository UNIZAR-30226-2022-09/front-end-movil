import 'package:alejandria/models/comentario_model.dart';
import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostBottom extends StatelessWidget {
  PostListModel post;

  PostBottom({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 60,
      width: 290,
      decoration: _buildBoxDecoration(),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        GestureDetector(
          onTap: () {
            //TODO: llamar a función dar Like
          },
          child: post.likemio
              ? Icon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.red[400],
                )
              : Icon(FontAwesomeIcons.heart),
        ),
        SizedBox(
          width: 5,
        ),
        Text('${post.nlikes}'),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'comentarios', arguments: {
                'descripcion': post.descripcion,
                'id_publicacion': post.id
              });
            },
            child: Icon(FontAwesomeIcons.comment)),
        SizedBox(
          width: 5,
        ),
        Text('${post.ncomentarios}'),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
            onTap: () {
              //TODO: llamar a función dar guardar
            },
            child: post.guardadomio
                ? Icon(FontAwesomeIcons.solidFloppyDisk)
                : Icon(FontAwesomeIcons.floppyDisk)),
        SizedBox(
          width: 5,
        ),
        Text('${post.nguardados}'),
        SizedBox(
          width: 20,
        ),
        GestureDetector(child: Icon(FontAwesomeIcons.shareNodes)),
      ]),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Preferences.isDarkMode
          ? Colors.white10
          : Colors.white.withOpacity(0.85),
      border: Border.all(color: AppTheme.primary.withOpacity(0.7)),
      borderRadius: post.tipo == 1
          ? BorderRadius.only(topLeft: Radius.circular(20))
          : BorderRadius.only(
              bottomRight: Radius.circular(18), topLeft: Radius.circular(20)));
}
