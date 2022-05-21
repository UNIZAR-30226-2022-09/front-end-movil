import 'dart:async';

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
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  Future<void> _fetchData() async {
    final postService = Provider.of<MyPostsService>(context, listen: false);
    postService.loadHome();
  }

  Future<void> _fetchMoreData() async {
    if (isLoading) return;
    isLoading = true;
    final postService = Provider.of<MyPostsService>(context, listen: false);
    await postService.loadMoreHome();
    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels + 500) >=
          _scrollController.position.maxScrollExtent) {
        _fetchMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _refresh() async {
      final pstService = Provider.of<MyPostsService>(context, listen: false);
      await pstService.loadHome();
    }

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
                onPressed: () {
                  Navigator.pushNamed(context, 'chatList');
                },
                icon: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: AppTheme.primary,
                  size: 30,
                ))
          ],
          bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
        ),
        body: articlesService.postsHome.length == 0
            ? RefreshIndicator(
                onRefresh: _fetchData,
                color: AppTheme.primary,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: NoPosts(
                            'Sigue a mas usuarios para ver sus publicaciones',
                            FontAwesomeIcons.solidUser),
                      );
                    }),
              )
            : RefreshIndicator(
                onRefresh: _refresh,
                color: AppTheme.primary,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: articlesService.postsHome.length,
                    itemBuilder: (BuildContext context, int index) {
                      return articlesService.postsHome[index].tipo == 1
                          ? ArticlePost(post: articlesService.postsHome[index])
                          : RecommendationPost(
                              post: articlesService.postsHome[index]);
                    }),
              ));
  }
}
