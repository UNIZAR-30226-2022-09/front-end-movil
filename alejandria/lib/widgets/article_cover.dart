import 'package:flutter/material.dart';

class ArticleCover extends StatelessWidget {
  const ArticleCover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
    );
  }
}
