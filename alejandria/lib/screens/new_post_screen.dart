import 'package:alejandria/models/post_model.dart';
import 'package:alejandria/provider/provider.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Logo(),
            SizedBox(
              height: 40,
            ),
            _Selection(
                title: 'Nuevo artículo',
                description:
                    'Comparte uno de tus trabajos con nuestra comunidad de usuarios',
                route: 'newArticle',
                tipo: 1),
            SizedBox(
              height: 40,
            ),
            _Selection(
                title: 'Nueva recomendación',
                description:
                    'Recomienda el trabajo de otro autor que te haya parecido interesante',
                route: 'newRecoommendation',
                tipo: 2),
          ],
        ),
      ),
    );
  }
}

class _Selection extends StatelessWidget {
  final String title;
  final String description;
  final String route;
  final int tipo;

  const _Selection({
    Key? key,
    required this.title,
    required this.description,
    required this.route,
    required this.tipo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final tematicas =
            Provider.of<TematicasProvider>(context, listen: false);
        tematicas.resetData();
        PostService articlePost =
            Provider.of<PostService>(context, listen: false);
        articlePost.resetData(tipo);
        Navigator.pushNamed(context, route);
      },
      child: Container(
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: AppTheme.primary,
              border: Border.all(color: AppTheme.dark, width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Preferences.isDarkMode ? Colors.black : Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color:
                        Preferences.isDarkMode ? Colors.black : Colors.white))
          ]),
        ),
      ),
    );
  }
}
