import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/bottom_line_appbar.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({Key? key}) : super(key: key);

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
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
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: MediaQuery.of(context).size.width * 0.7),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int indx) {
                    return ArticleCover();
                  },
                ),
              ),
              SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int indx) {
                      return RecommendationPost();
                    }),
              ),
            ]));
  }
}
