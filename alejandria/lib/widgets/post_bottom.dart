import 'dart:convert';

import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/provider/tematicas_provider.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PostBottom extends StatefulWidget {
  PostListModel post;

  PostBottom({Key? key, required this.post}) : super(key: key);

  @override
  State<PostBottom> createState() => _PostBottomState();
}

class _PostBottomState extends State<PostBottom> {
  final String _baseUrl = '51.255.50.207:5000';
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 60,
      width: 290,
      decoration: _buildBoxDecoration(),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        GestureDetector(
          onTap: () async {
            widget.post.nlikes = widget.post.likemio
                ? widget.post.nlikes - 1
                : widget.post.nlikes + 1;
            widget.post.likemio = !widget.post.likemio;
            setState(() {});
            /*
            final url = Uri.http(_baseUrl, '/darLike');
            await http.post(url,
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'token': await storage.read(key: 'token') ?? ''
                },
                body: json.encode(<String, dynamic>{
                  'id': widget.post.id!,
                  'like': widget.post.likemio
                })); */
          },
          child: widget.post.likemio
              ? Icon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.red[400],
                )
              : Icon(FontAwesomeIcons.heart),
        ),
        SizedBox(
          width: 5,
        ),
        Text('${widget.post.nlikes}'),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'comentarios', arguments: {
                'descripcion': widget.post.descripcion,
                'id_publicacion': widget.post.id,
                'foto_de_perfil_user': widget.post.fotoDePerfil
              });
            },
            child: Icon(FontAwesomeIcons.comment)),
        SizedBox(
          width: 5,
        ),
        Text('${widget.post.ncomentarios}'),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
            onTap: () async {
              widget.post.nguardados = widget.post.guardadomio
                  ? widget.post.nguardados - 1
                  : widget.post.nguardados + 1;
              widget.post.guardadomio = !widget.post.guardadomio;
              setState(() {});
              /*
              final url = Uri.http(_baseUrl, '/guardar');
              await http.post(url,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'token': await storage.read(key: 'token') ?? ''
                  },
                  body: json.encode(<String, dynamic>{
                    'id': widget.post.id!,
                    'guardar': widget.post.guardadomio
                  })); */
            },
            child: widget.post.guardadomio
                ? Icon(FontAwesomeIcons.solidFloppyDisk)
                : Icon(FontAwesomeIcons.floppyDisk)),
        SizedBox(
          width: 5,
        ),
        Text('${widget.post.nguardados}'),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
            onTap: () {
              final tematicas =
                  Provider.of<TematicasProvider>(context, listen: false);
              tematicas.resetData();
              PostService articlePost =
                  Provider.of<PostService>(context, listen: false);
              articlePost.resetData(2);
              if (widget.post.tipo == 2) {
                Navigator.pushNamed(context, 'newRecoommendation', arguments: {
                  'link': 'https://www.alejandria.es/${widget.post.id}',
                  'titulo': widget.post.titulo,
                  'autor': widget.post.autor,
                });
              }
            },
            child: Icon(FontAwesomeIcons.shareNodes)),
      ]),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Preferences.isDarkMode
          ? Colors.white10
          : Colors.white.withOpacity(0.85),
      border: Border.all(color: AppTheme.primary.withOpacity(0.7)),
      borderRadius: widget.post.tipo == 1 && widget.post.descripcion != 'None'
          ? BorderRadius.only(topLeft: Radius.circular(20))
          : BorderRadius.only(
              bottomRight: Radius.circular(18), topLeft: Radius.circular(20)));
}
