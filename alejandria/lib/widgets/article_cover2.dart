import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/screens/una_prueba.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:alejandria/screens/una_prueba.dart';

class ArticleCover2 extends StatelessWidget {
  PostListModel post;

  ArticleCover2(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'onePost', arguments: {'post': post});
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[400],
            child: FadeInImage(
                fit: BoxFit.cover,
                placeholderFit: BoxFit.contain,
                placeholder: AssetImage('assets/carga.jpg'),
                image: NetworkImage(post.portada!)),
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primary),
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
