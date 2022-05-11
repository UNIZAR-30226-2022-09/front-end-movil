import 'dart:async';

import 'package:alejandria/models/models.dart';
import 'package:alejandria/services/my_posts_service.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/no_info.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future? myFuture;

  Future<List<PostListModel>> _fetchData() async {
    final postService = Provider.of<MyPostsService>(context, listen: false);
    return postService.loadHome();
  }

  @override
  void initState() {
    super.initState();
    myFuture = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final articlesService = Provider.of<MyPostsService>(context);
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
      body: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppTheme.primary,
              ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return articlesService.postsHome.length == 0
                  ? Center(
                      child: NoPosts(
                          'Sigue a mas usuarios para ver sus publicaciones',
                          FontAwesomeIcons.solidUser),
                    )
                  : ListView.builder(
                      itemCount: articlesService.postsHome.length,
                      itemBuilder: (BuildContext context, int index) {
                        return articlesService.postsHome[index].tipo == 1
                            ? ArticlePost(
                                post: articlesService.postsHome[index])
                            : RecommendationPost(
                                post: articlesService.postsHome[index]);
                      });
            }
            return Container();
          }),
    );
  }
}
