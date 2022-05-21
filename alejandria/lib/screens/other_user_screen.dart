import 'dart:convert';

import 'package:alejandria/models/models.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/no_info.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../share_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class OtherUserScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const OtherUserScreen(this.args, {Key? key}) : super(key: key);
  @override
  State<OtherUserScreen> createState() => _OtherUserScreenState();
}

class _OtherUserScreenState extends State<OtherUserScreen>
    with SingleTickerProviderStateMixin {
  Future? myFuture;

  late String nick;

  late TabController _tabController2;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  Future<void> _fetchMorePosts(bool i) async {
    if (isLoading) return;
    isLoading = true;
    final postService = Provider.of<MyPostsService>(context, listen: false);
    if (i) {
      await postService.loadMoreArticles(nick);
    } else {
      await postService.loadMoreRecs(nick);
    }

    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    nick = widget.args?['nick'];
    myFuture = _getUser(nick);
    _tabController2 = TabController(length: 2, vsync: this);
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels + 500) >=
          _scrollController.position.maxScrollExtent) {
        if (_tabController2.index == 0) {
          _fetchMorePosts(true);
        } else {
          _fetchMorePosts(false);
        }
      }
    });
  }

  Future<void> _getUser(String nick) async {
    final userService = Provider.of<UserService>(context, listen: false);
    final articlesService = Provider.of<MyPostsService>(context, listen: false);
    await userService.loadOtherUser(nick);
    await articlesService.loadArticles(nick);
    await articlesService.loadRecs(nick);
    return;
  }

  @override
  build(BuildContext context) {
    final postsService = Provider.of<MyPostsService>(context);
    final userService = Provider.of<UserService>(context);
    Future<void> _onRefresh() async {
      await userService.loadOtherUser(nick);
      await postsService.loadArticles(nick);
      await postsService.loadRecs(nick);
    }

    return WillPopScope(
      onWillPop: () {
        postsService.resetOtherPosts();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(nick,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary)),
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
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: AppTheme.primary,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          _UpperContent(userService.otherUser),
                          _Posts(_tabController2),
                        ],
                      )),
                );
              }
              return Container(
                child: Text('Error'),
              );
            }),
      ),
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
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/icon.png'),
                      image: NetworkImage(widget.thisUser.fotoDePerfil!),
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
      if (widget.thisUser.nombreDeUsuario != null &&
          widget.thisUser.nombreDeUsuario!.length > 0)
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Text(
            widget.thisUser.nombreDeUsuario!, //
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      if (widget.thisUser.descripcion != null &&
          widget.thisUser.descripcion!.length > 0)
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Text(widget.thisUser.descripcion!),
        ),
      if (widget.thisUser.link != null && widget.thisUser.link!.length > 0)
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    primary: widget.thisUser.siguiendo!
                        ? Colors.white
                        : AppTheme.primary,
                    backgroundColor:
                        widget.thisUser.siguiendo! ? AppTheme.primary : null,
                    side: BorderSide(color: AppTheme.primary)),
                child: Container(
                  alignment: Alignment.center,
                  width: 180,
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
                  final postsService =
                      Provider.of<MyPostsService>(context, listen: false);
                  postsService.loadHome();
                  setState(() {});
                }),
            SizedBox(width: 5),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    primary:AppTheme.primary,
                    backgroundColor: null,
                    side: BorderSide(color: AppTheme.primary)),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text('Mensaje'),
                ),
                onPressed: () {
                  final chatService = Provider.of<ChatService>(context, listen: false);
                  chatService.usuarioPara = widget.thisUser;
                  Navigator.pushNamed(context, 'chat');
                }),
          ],
        ),
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
  final _tabController2;

  _Posts(this._tabController2);
  @override
  State<_Posts> createState() => _PostsState();
}

class _PostsState extends State<_Posts> {
  int _SelectedTabBar = 0;

  @override
  Widget build(BuildContext context) {
    final postService = Provider.of<MyPostsService>(context);

    return Column(
      children: [
        Container(
          width: double.infinity,
          child: TabBar(
            onTap: (value) {
              _SelectedTabBar = value;
              setState(() {});
            },
            controller: widget._tabController2,
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
                  child: postService.otrosArticulos.length == 0
                      ? Column(
                          children: [
                            Container(
                              child: Column(children: [
                                NoPosts('Todavía no hay articulos',
                                    FontAwesomeIcons.file),
                                //Para que haya scroll
                                Container(
                                  width: double.infinity,
                                  height: 240,
                                )
                              ]),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent:
                                          MediaQuery.of(context).size.width *
                                              0.7),
                              itemCount: postService.otrosArticulos.length,
                              itemBuilder: (BuildContext context, int indx) {
                                return ArticleCover(
                                  post: postService.otrosArticulos[indx],
                                  dondeVoy: 2,
                                );
                              },
                            ),
                            postService.otrosArticulos.length < 3
                                ? Container(
                                    width: double.infinity,
                                    height: 130,
                                  )
                                : Container()
                          ],
                        ),
                )
              : Container(
                  child: postService.otrasRecs.length == 0
                      ? Column(
                          children: [
                            Container(
                              child: Column(children: [
                                NoPosts('Todavía no hay recomendaciones',
                                    FontAwesomeIcons.thumbsUp),
                                Container(
                                  width: double.infinity,
                                  height: 240,
                                )
                              ]),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: postService.otrasRecs.length,
                                itemBuilder: (BuildContext context, int indx) {
                                  return RecommendationPost(
                                      post: postService.otrasRecs[indx]);
                                }),
                            postService.otrasRecs.length == 1
                                ? Container(width: double.infinity, height: 215)
                                : Container()
                          ],
                        ),
                );
        })
      ],
    );
  }
}
