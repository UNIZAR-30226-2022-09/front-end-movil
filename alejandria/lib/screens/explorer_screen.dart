import 'package:alejandria/models/tematica_model.dart';
import 'package:alejandria/provider/tematicas_provider.dart';
import 'package:alejandria/search/search_delegate.dart';
import 'package:alejandria/services/my_posts_service.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/card_swipper_recs.dart';
import 'package:alejandria/widgets/no_info.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ExplorerScreen extends StatefulWidget {
  const ExplorerScreen({Key? key}) : super(key: key);

  @override
  State<ExplorerScreen> createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explorador',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary)),
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MySearchDelegate()),
              icon: Icon(
                Icons.search,
                color: AppTheme.primary,
                size: 30,
              ))
        ],
        bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(_controller),
            Container(
              width: double.infinity,
              height: 0.5,
              color: AppTheme.primary,
            ),
            TabBarW(_tabController, _controller)
          ],
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  final TextEditingController _contrller;
  const _Header(this._contrller);

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            _ListaTematicas(width: size.width * 0.8),
            SizedBox(
              width: 2,
            ),
            GestureDetector(
              onTap: () {
                _isVisible = !_isVisible;
                setState(() {});
              },
              child: Container(
                  width: size.width * 0.19,
                  height: 77,
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: AppTheme.primary.withOpacity(0.5)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.filter,
                        color: Preferences.isDarkMode
                            ? Colors.white54
                            : Colors.black54,
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded,
                          color: Preferences.isDarkMode
                              ? Colors.white54
                              : Colors.black54)
                    ],
                  )),
            ),
          ],
        ),
        if (_isVisible) _FadeInOut(widget._contrller)
      ],
    );
  }
}

class _FadeInOut extends StatelessWidget {
  final TextEditingController _contrller;
  _FadeInOut(this._contrller);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: AppTheme.primary.withOpacity(0.5)))),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: MediaQuery.of(context).size.width * 0.75,
              height: 45,
              child: TextFormField(
                controller: _contrller,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    hintText: 'Palabra(s) clave', prefixIcon: Icon(Icons.abc)),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              color: AppTheme.primary,
              child: Container(
                alignment: Alignment.center,
                height: 45,
                child: Text(
                  'Buscar',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              onPressed: () async {
                print(_contrller.text);
                final tematicas =
                    Provider.of<TematicasProvider>(context, listen: false);
                final postsService =
                    Provider.of<MyPostsService>(context, listen: false);
                await postsService.LoadNovedades(
                    tematicas.selectedTemaTica, _contrller.text);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            )
          ],
        ));
  }
}

class _ListaTematicas extends StatelessWidget {
  final double width;

  const _ListaTematicas({Key? key, required this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tematicas = Provider.of<TematicasProvider>(context).tematicas;

    return Container(
      width: width,
      height: 77,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: tematicas.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _TematicaBoton(tematicas[index]),
                SizedBox(height: 5),
                Text(tematicas[index].name)
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TematicaBoton extends StatelessWidget {
  final Tematica tematica;

  const _TematicaBoton(this.tematica);

  @override
  Widget build(BuildContext context) {
    final tematicaProvider = Provider.of<TematicasProvider>(context);

    return GestureDetector(
      onTap: () async {
        final tematicas =
            Provider.of<TematicasProvider>(context, listen: false);
        tematicas.selectedTematica = tematica.dbName;
        final postsService =
            Provider.of<MyPostsService>(context, listen: false);
        await postsService.LoadNovedades(tematica.dbName, "");
      },
      child: Container(
        width: 45,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (tematicaProvider.selectedTemaTica == this.tematica.dbName)
              ? null
              : Colors.grey[300],
          gradient: (tematicaProvider.selectedTemaTica == this.tematica.dbName)
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.9)])
              : null,
        ),
        child: Icon(
          tematica.icon,
          color: (tematicaProvider.selectedTemaTica == this.tematica.dbName)
              ? Colors.white
              : AppTheme.primary,
        ),
      ),
    );
  }
}

class TabBarW extends StatefulWidget {
  final _tabController;
  final _textController;
  TabBarW(this._tabController, this._textController);

  @override
  State<TabBarW> createState() => _TabBarWState();
}

class _TabBarWState extends State<TabBarW> {
  int _SelectedTabBar = 0;
  Future? myFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = GetPosts();
  }

  Future<void> GetPosts() async {
    final tematicas = Provider.of<TematicasProvider>(context, listen: false);
    final postsService = Provider.of<MyPostsService>(context, listen: false);
    await postsService.LoadPopularesR(tematicas.selectedTemaTica, '');
    await postsService.LoadPopulares(tematicas.selectedTemaTica, "");
    await postsService.LoadNovedades(tematicas.selectedTemaTica, "");
  }

  @override
  Widget build(BuildContext context) {
    final postsService = Provider.of<MyPostsService>(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: TabBar(
            onTap: (value) {
              _SelectedTabBar = value;
              setState(() {});
            },
            controller: widget._tabController,
            unselectedLabelColor: Colors.grey,
            labelColor: AppTheme.primary,
            indicatorColor: AppTheme.primary,
            tabs: [
              Tab(icon: Text('Ver Artículos', style: TextStyle(fontSize: 15))),
              Tab(
                  icon: Text('Ver Recomendaciones',
                      style: TextStyle(fontSize: 15))),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Builder(builder: (_) {
          return _SelectedTabBar == 0
              ? FutureBuilder(
                  future: myFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppTheme.primary,
                      ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return postsService.novedades.length == 0
                          ? NoPosts('Ningún resultado coincide con tu búsqueda',
                              Icons.search_off)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 5, bottom: 15),
                                  child: Text(
                                    'Novedades',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                                CardSwiper(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 10, top: 25),
                                  child: Text(
                                    'Populares',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisExtent:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.43),
                                      itemCount: postsService.populares.length,
                                      itemBuilder:
                                          (BuildContext context, int indx) {
                                        return ArticleCover(
                                            post: postsService.populares[indx],
                                            dondeVoy: 2);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            );
                    }
                    return Container();
                  })
              : postsService.popularesR.length != 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 5, bottom: 15),
                            child: Text(
                              'Novedades',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          CardSwiperRecs(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, bottom: 10, top: 15),
                            child: Text(
                              'Populares',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: postsService.popularesR.length,
                                itemBuilder: (BuildContext context, int indx) {
                                  return RecommendationPost(
                                      post: postsService.popularesR[indx]);
                                }),
                          )
                        ])
                  : NoPosts('Ningún resultado coincide con tu búsqueda',
                      Icons.search_off);
        })
      ],
    );
  }
}
