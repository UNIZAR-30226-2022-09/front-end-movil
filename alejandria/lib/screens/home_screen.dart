import 'package:alejandria/models/models.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALEJANDRÍA',
            style: TextStyle(
                fontFamily: 'Amazing Grotesc Ultra',
                fontSize: 30,
                color: AppTheme.primary)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppTheme.primary,
                size: 30,
              ))
        ],
        bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
      ),
      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return index % 2 == 0
                ? ArticlePost(
                    post: PostListModel(
                        tipo: 1,
                        usuario: "alvaroPomarMart",
                        fotoDePerfil:
                            'https://www.emprendedores.es/wp-content/uploads/2021/05/De-emprendedor-a-empresario.jpg',
                        pdf:
                            'http://51.255.50.207:5000/display2/Practica2_21_22.pdf',
                        portada: 'http://51.255.50.207:5000/display3/1.png',
                        nlikes: 30,
                        likemio: true,
                        ncomentarios: 10,
                        nguardados: 7,
                        guardadomio: false,
                        descripcion: 'mi articulo propio'))
                : RecommendationPost(
                    post: PostListModel(
                        tipo: 2,
                        usuario: 'alvaro',
                        fotoDePerfil:
                            'https://www.emprendedores.es/wp-content/uploads/2021/05/De-emprendedor-a-empresario.jpg',
                        nlikes: 10,
                        likemio: false,
                        ncomentarios: 2,
                        nguardados: 4,
                        guardadomio: true,
                        titulo: 'UN articulo',
                        autor: 'Alvaro Pomar',
                        descripcion: 'Este articulo es muy intersante ',
                        link: 'https://www.google.com'));
          }),
    );
  }
}
