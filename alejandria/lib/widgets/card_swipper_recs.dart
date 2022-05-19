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
        itemCount: postsService.novedadesR.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.95,
        itemHeight: 280,
        itemBuilder: (_, int index) {
          return RecommendationPost(post: postsService.novedadesR[index]);
          //ArticleCover2(postsService.novedades[index]);
        },
      ),
    );
  }
}
