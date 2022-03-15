import 'package:flutter/material.dart';

class NewArticleScreen extends StatelessWidget {
  const NewArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Hola'),
      ),
      body: Center(
        child: Text('NewArticleScreen'),
      ),
    );
  }
}
