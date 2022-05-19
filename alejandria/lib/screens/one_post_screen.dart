import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/screens/una_prueba.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnePostScreen extends StatelessWidget {
  final PostListModel? myPost;
  final int? dondeVoy;
  OnePostScreen({Key? key, this.myPost, this.dondeVoy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    PostListModel post = arguments['post'] != null ? arguments['post'] : myPost;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (dondeVoy != null) {
                  final prueba =
                      Provider.of<PruebaProvider>(context, listen: false);
                  prueba.changeScreen(true, null);
                } else {
                  Navigator.pop(context);
                }
              }),
          title: Text('Post de ${post.usuario}',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary)),
          bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
        ),
        body: SingleChildScrollView(
          child: post.tipo == 1
              ? Hero(tag: post.id!, child: ArticlePost(post: post))
              : RecommendationPost(post: post),
        ));
  }
}
