import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ArticlePost extends StatelessWidget {
  PostListModel post;
  ArticlePost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: _cardBorders(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                _BackgroundImage(size, post.pdf!, post.usuario, post.portada!,
                    post.descripcion! != 'None'),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: PostBottom(
                      post: post,
                    )),
                Positioned(
                    top: 0,
                    left: 0,
                    child: PostHeader(
                        '@${post.usuario}', size, post.fotoDePerfil)),
              ],
            ),
            _Description(post.descripcion)
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
                color: AppTheme.primary.withOpacity(0.3),
                offset: Offset(0, 3),
                blurRadius: 10)
          ]);
}

class _BackgroundImage extends StatelessWidget {
  final Size size;
  final String pdf;
  final String portada;
  final String user_name;
  final bool rounded;
  const _BackgroundImage(
      this.size, this.pdf, this.user_name, this.portada, this.rounded);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: !rounded
          ? BorderRadius.circular(20)
          : BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
      child: Container(
        width: size.width * 0.95,
        height: size.width * 1.34,
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: FadeInImage(
                fit: BoxFit.cover,
                placeholderFit: BoxFit.cover,
                placeholder: AssetImage('assets/carga.jpg'),
                //image: AssetImage('assets/carga.jpg')
                image: NetworkImage(portada)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'pdfScreen',
                  arguments: {'pdf': pdf, 'user': user_name});
            },
            child: Container(
              color: Colors.black.withOpacity(0.001),
            ),
          )
        ]),
        decoration: BoxDecoration(
          color: Preferences.isDarkMode ? Colors.black87 : Colors.white,
          border: Border(bottom: BorderSide(color: AppTheme.primary)),
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  String? descripcion;
  _Description(this.descripcion);

  @override
  Widget build(BuildContext context) {
    return descripcion != null && descripcion != 'None'
        ? Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(descripcion!),
            ),
            decoration: BoxDecoration(
              color: Preferences.isDarkMode ? Colors.black87 : Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          )
        : Container();
  }
}
