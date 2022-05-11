import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/services/my_posts_service.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/no_info.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({Key? key}) : super(key: key);

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen>
    with TickerProviderStateMixin {
  late List<PostListModel> savedArticles;
  late List<PostListModel> savedRecs;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    final ssService = Provider.of<MyPostsService>(context, listen: false);
    Future<void> getSavedArticles() async {
      savedArticles = await ssService.loadSavedArticles();
    }

    Future<void> getSavedRecs() async {
      savedRecs = await ssService.loadSavedRecs();
    }

    return Scaffold(
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
          ), //Color.fromRGBO(68, 114, 88, 1),
        ),
        body: TabBarView(
            controller: _tabController,
            physics: BouncingScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: FutureBuilder(
                    future: getSavedArticles(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return savedArticles.length == 0
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
                                itemCount: savedArticles.length,
                                itemBuilder: (BuildContext context, int indx) {
                                  return ArticleCover(
                                    post: savedArticles[indx],
                                    dondeVoy: 2,
                                  );
                                },
                              );
                      }
                      return Container();
                    }),
              ),
              SingleChildScrollView(
                child: FutureBuilder(
                    future: getSavedRecs(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return savedRecs.length == 0
                            ? NoPosts(
                                'Todavía no has guardado ninguna recomendación',
                                FontAwesomeIcons.thumbsUp)
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: savedRecs.length,
                                itemBuilder: (BuildContext context, int indx) {
                                  return RecommendationPost(
                                      post: savedRecs[indx]);
                                });
                      }
                      return Container();
                    }),
              ),
            ]));
  }
}
