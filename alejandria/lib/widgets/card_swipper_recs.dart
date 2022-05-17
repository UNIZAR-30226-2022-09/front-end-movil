import 'package:alejandria/models/models.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/widgets/article_cover2.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

class CardSwiperRecs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postsService = Provider.of<MyPostsService>(context);

    return Container(
      width: double.infinity,
      child: Swiper(
        itemCount: 2, //postsService.novedades.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.95,
        itemHeight: 250,
        itemBuilder: (_, int index) {
          return RecommendationPost(
              post: PostListModel(
                  tipo: 2,
                  usuario: 'raul',
                  fotoDePerfil: 'http://51.255.50.207:5000/display/raul.jpg',
                  titulo: 'Explorador',
                  autor: 'funciona?',
                  descripcion:
                      'Esto es una prueba muy importante super mega importante ultra mecra macro hiper importante',
                  link: 'https://www.google.com',
                  nlikes: 3,
                  likemio: true,
                  ncomentarios: 1,
                  nguardados: 2,
                  guardadomio: false));
          //ArticleCover2(postsService.novedades[index]);
        },
      ),
    );
  }
}
