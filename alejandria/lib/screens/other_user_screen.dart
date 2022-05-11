import 'dart:convert';

import 'package:alejandria/models/models.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../share_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class OtherUserScreen extends StatefulWidget {
  @override
  State<OtherUserScreen> createState() => _OtherUserScreenState();
}

class _OtherUserScreenState extends State<OtherUserScreen> {
  @override
  build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    final articlesService = Provider.of<MyPostsService>(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    late UserModel thisUser;
    late List<PostListModel> thisUserArticles;
    late List<PostListModel> thisUserRecs;

    Future<void> getUser() async {
      thisUser = await userService.loadOtherUser(arguments['nick']);
      thisUserArticles =
          await articlesService.loadOtherArticles(arguments['nick']);
      thisUserRecs = await articlesService.loadOtherRecs(arguments['nick']);
      return;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['nick'],
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary)),
        bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
      ),
      body: FutureBuilder(
          future: getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppTheme.primary,
              ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  _UpperContent(thisUser),
                  _Posts(thisUserArticles, thisUserRecs)
                ],
              ));
            }
            return Container(
              child: Text('Error'),
            );
          }),
    );
  }
}

class _UpperContent extends StatefulWidget {
  final UserModel thisUser;

  _UpperContent(this.thisUser);

  @override
  State<_UpperContent> createState() => _UpperContentState();
}

class _UpperContentState extends State<_UpperContent> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 100,
                  height: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      imageUrl: widget.thisUser.fotoDePerfil!,
                    ),
                  )),
              SizedBox(
                width: 30,
              ),
              _numbers(number: widget.thisUser.nposts, msg: 'Posts'),
              SizedBox(
                width: 15,
              ),
              _numbers(number: widget.thisUser.nseguidores, msg: 'Seguidores'),
              SizedBox(
                width: 15,
              ),
              _numbers(number: widget.thisUser.nsiguiendo, msg: 'Siguiendo')
            ],
          )),
      if (widget.thisUser.nombreDeUsuario != null)
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Text(
            widget.thisUser.nombreDeUsuario!, //
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      if (widget.thisUser.descripcion != null)
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Text(widget.thisUser.descripcion!),
        ),
      if (widget.thisUser.link != null)
        Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
            child: GestureDetector(
              child: Text(
                widget.thisUser.link!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Preferences.isDarkMode
                        ? Colors.blue[200]
                        : Colors.blue[900]),
              ),
              onTap: () async {
                launch(widget.thisUser.link!);
              },
            )),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                primary: widget.thisUser.siguiendo!
                    ? Colors.white
                    : AppTheme.primary,
                backgroundColor:
                    widget.thisUser.siguiendo! ? AppTheme.primary : null,
                side: BorderSide(color: AppTheme.primary)),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(widget.thisUser.siguiendo! ? 'Siguiendo' : 'Seguir'),
            ),
            onPressed: () async {
              final storage = new FlutterSecureStorage();
              final String _baseUrl = '51.255.50.207:5000';
              final url = Uri.http(_baseUrl, '/seguirUser');
              await http.post(url,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'token': await storage.read(key: 'token') ?? '',
                  },
                  body: json.encode(<String, dynamic>{
                    'nick': widget.thisUser.nick,
                  }));
              widget.thisUser.siguiendo = !widget.thisUser.siguiendo!;
              widget.thisUser.nseguidores = widget.thisUser.siguiendo!
                  ? widget.thisUser.nseguidores + 1
                  : widget.thisUser.nseguidores - 1;
              setState(() {});
            }),
      )
    ]);
  }
}

class _numbers extends StatelessWidget {
  final int number;
  final String msg;

  const _numbers({
    Key? key,
    required this.number,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$number',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        SizedBox(
          height: 5,
        ),
        Text(msg)
      ],
    );
  }
}

class _Posts extends StatefulWidget {
  final List<PostListModel> articles;
  final List<PostListModel> recs;

  _Posts(this.articles, this.recs);
  @override
  State<_Posts> createState() => _PostsState();
}

class _PostsState extends State<_Posts> with SingleTickerProviderStateMixin {
  int _SelectedTabBar = 0;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: TabBar(
            onTap: (value) {
              _SelectedTabBar = value;
              setState(() {});
            },
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
        SizedBox(
          height: 5,
        ),
        Builder(builder: (_) {
          return _SelectedTabBar == 0
              ? Container(
                  child: widget.articles.length == 0
                      ? Container(
                          child: Column(children: [
                            SizedBox(
                              height: 90,
                            ),
                            FaIcon(
                              FontAwesomeIcons.file,
                              size: 100,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Todavía no hay articulos',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 19,
                                  fontStyle: FontStyle.italic),
                            )
                          ]),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent:
                                      MediaQuery.of(context).size.width * 0.7),
                          itemCount: widget.articles.length,
                          itemBuilder: (BuildContext context, int indx) {
                            return ArticleCover(
                              post: widget.articles[indx],
                              dondeVoy: 2,
                            );
                          },
                        ),
                )
              : Container(
                  child: widget.recs.length == 0
                      ? Container(
                          child: Column(children: [
                            SizedBox(
                              height: 90,
                            ),
                            FaIcon(
                              FontAwesomeIcons.thumbsUp,
                              size: 100,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Todavía no hay recomendaciones',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 19,
                                  fontStyle: FontStyle.italic),
                            )
                          ]),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.recs.length,
                          itemBuilder: (BuildContext context, int indx) {
                            return RecommendationPost(post: widget.recs[indx]);
                          }),
                );
        })
      ],
    );
  }
}
