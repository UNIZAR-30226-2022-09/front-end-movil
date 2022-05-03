import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ArticleCover extends StatelessWidget {
  PostListModel? post;
  ArticleCover({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, 'onePost');
        Navigator.pushNamed(context, 'onePost');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
