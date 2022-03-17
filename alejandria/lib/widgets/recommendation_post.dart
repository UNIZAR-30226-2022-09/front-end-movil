import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationPost extends StatelessWidget {
  const RecommendationPost({
    Key? key,
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
            _Recommendation(),
            Positioned(
                bottom: 0,
                right: 0,
                child: PostBottom(
                  isArticle: false,
                )),
            Positioned(
                top: 0, left: 0, child: PostHeader('@nombreDeUsuario', size)),
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
