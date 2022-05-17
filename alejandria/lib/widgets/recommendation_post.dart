import 'package:alejandria/services/my_posts_service.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/post_list_model.dart';

class RecommendationPost extends StatelessWidget {
  PostListModel post;
  RecommendationPost({
    Key? key,
    required this.post,
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
            _Recommendation(post),
            Positioned(bottom: 0, right: 0, child: PostBottom(post: post)),
            Positioned(
                top: 0,
                left: 0,
                child: PostHeader('@${post.usuario}', size, post.fotoDePerfil)),
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

class _Recommendation extends StatelessWidget {
  PostListModel post;
  _Recommendation(this.post);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        color: Preferences.isDarkMode ? Colors.black : Colors.grey[50],
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 70),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '${post.titulo!} - ${post.autor!}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Text(post.descripcion!),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: Text(
              post.link!.contains('https://www.alejandria.es')
                  ? 'ver post original'
                  : post.link!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Preferences.isDarkMode
                      ? Colors.blue[200]
                      : Colors.blue[900]),
            ),
            onTap: () async {
              if (post.link!.contains('https://www.alejandria.es')) {
                final splitted = post.link!.split('/');
                final postService = Provider.of<MyPostsService>(context);
                final thisPost =
                    postService.getInfoPost(splitted[splitted.length - 1]);
                Navigator.pushNamed(context, 'onePost',
                    arguments: {'post': thisPost});
              } else
                launch(post.link!);
            },
          )
        ]),
      ),
    );
  }
}
