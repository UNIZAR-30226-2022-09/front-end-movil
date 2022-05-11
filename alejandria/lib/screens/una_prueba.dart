import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/screens/one_post_screen.dart';
import 'package:alejandria/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PruebaProvider with ChangeNotifier {
  bool total = true;
  PostListModel? myPost;
  void changeScreen(bool change, PostListModel? myPost) {
    total = change;
    this.myPost = myPost;
    notifyListeners();
  }
}

class UnaPruebaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prueba = Provider.of<PruebaProvider>(context);
    return prueba.total
        ? UserScreen()
        : OnePostScreen(
            myPost: prueba.myPost,
            dondeVoy: 1,
          );
  }
}
