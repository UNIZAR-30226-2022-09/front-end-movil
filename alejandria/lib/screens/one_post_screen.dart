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
    final userService = Provider.of<UserService>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Post de ${userService.user.nick}',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary)),
          bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
        ),
        body: SingleChildScrollView(
          child: ArticlePost(
              post: PostListModel(
                  tipo: 1,
                  usuario: "alvaro",
                  fotoDePerfil:
                      'https://www.emprendedores.es/wp-content/uploads/2021/05/De-emprendedor-a-empresario.jpg',
                  nlikes: 30,
                  likemio: true,
                  ncomentarios: 10,
                  nguardados: 7,
                  guardadomio: false,
                  descripcion: 'mi articulo propio')),
        ));
  }
}
