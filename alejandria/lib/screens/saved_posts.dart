import 'package:alejandria/services/my_posts_service.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/no_info.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/notificaciones_service.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({Key? key}) : super(key: key);

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollControllerA = ScrollController();
  final ScrollController _scrollControllerR = ScrollController();
  Future? myFuture;

  bool isLoading = false;

  Future<void> getSavedPosts() async {
    final ssService = Provider.of<MyPostsService>(context, listen: false);
    await ssService.loadSavedArticles();
    await ssService.loadSavedRecs();
    final m = Provider.of<NotificacionesService>(context, listen: false);
    m.loadNotificaciones();
  }

  Future<void> _fetchMore(bool isArticle) async {
    if (isLoading) return;
    isLoading = true;
    final ssService = Provider.of<MyPostsService>(context, listen: false);
    isArticle
        ? await ssService.loadMoreSavedArticles()
        : await ssService.loadMoreSavedRecs();
    Future.delayed(const Duration(seconds: 2));
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    myFuture = getSavedPosts();
    _scrollControllerA.addListener(() {
      if ((_scrollControllerA.position.pixels + 500) >=
          _scrollControllerA.position.maxScrollExtent) {
        _fetchMore(true);
      }
    });
    _scrollControllerR.addListener(() {
      if ((_scrollControllerR.position.pixels + 500) >=
          _scrollControllerR.position.maxScrollExtent) {
        _fetchMore(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ssService = Provider.of<MyPostsService>(context);

    return WillPopScope(
      onWillPop: () {
        ssService.resetSavedPosts();
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Posts Guardados',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary)),
            bottom: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.grey,
              labelColor: AppTheme.primary,
              indicatorColor: AppTheme.primary,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.space_dashboard_outlined,
                )),
                Tab(icon: Icon(Icons.thumb_up_outlined)),
              ],
            ),
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
                return TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        controller: _scrollControllerA,
                        child: ssService.misArticulosG.length == 0
                            ? NoPosts('Todavía no has guardado ningun artículo',
                                FontAwesomeIcons.file)
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent:
                                            MediaQuery.of(context).size.width *
                                                0.7),
                                itemCount: ssService.misArticulosG.length,
                                itemBuilder: (BuildContext context, int indx) {
                                  return ArticleCover(
                                    post: ssService.misArticulosG[indx],
                                    dondeVoy: 2,
                                  );
                                },
                              ),
                      ),
                      SingleChildScrollView(
                        controller: _scrollControllerR,
                        child: ssService.misRecsG.length == 0
                            ? NoPosts(
                                'Todavía no has guardado ninguna recomendación',
                                FontAwesomeIcons.thumbsUp)
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: ssService.misRecsG.length,
                                itemBuilder: (BuildContext context, int indx) {
                                  return RecommendationPost(
                                      post: ssService.misRecsG[indx]);
                                }),
                      ),
                    ]);
              }
              return Container();
            },
          )),
    );
  }
}
