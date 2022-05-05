import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/bottom_line_appbar.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnePostScreen extends StatelessWidget {
  const OnePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    PostListModel post = arguments['post'];
    return Scaffold(
        appBar: AppBar(
          title: Text('Post de ${post.usuario}',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary)),
          bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
        ),
        body: SingleChildScrollView(
          child: ArticlePost(post: post),
        ));
  }
}
