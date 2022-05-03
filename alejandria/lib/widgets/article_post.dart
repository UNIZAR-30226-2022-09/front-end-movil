import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
                _BackgroundImage(size),
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
            _Description()
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
  const _BackgroundImage(this.size);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        width: size.width * 0.95,
        height: size.width * 1.34,
        decoration: BoxDecoration(
          color: Preferences.isDarkMode ? Colors.black87 : Colors.grey[400],
          border: Border(bottom: BorderSide(color: AppTheme.primary)),
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
            'Sint qui adipisicing consequat nisi tempor in ea voluptate adipisicing labore eiusmod anim eu. Eiusmod mollit excepteur excepteur eu velit pariatur fugiat qui commodo ullamco. Occaecat Lorem tempor do laboris eu nulla occaecat culpa quis.'),
      ),
      decoration: BoxDecoration(
        color: Preferences.isDarkMode ? Colors.black87 : Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}
