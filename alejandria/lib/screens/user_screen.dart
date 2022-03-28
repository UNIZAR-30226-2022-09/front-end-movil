import 'package:alejandria/provider/theme_provider.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('user_name',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary)),
        bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
      ),
      endDrawer: _MyDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [_UpperContent(), _Posts()],
      )),
    );
  }
}

class _MyDrawer extends StatelessWidget {
  const _MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
        child: Column(
          //physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'savedPosts');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: AppTheme.primary.withOpacity(0.5)),
                        bottom: BorderSide(
                            color: AppTheme.primary.withOpacity(0.5)))),
                child: ListTile(
                  leading: Icon(Icons.save, color: AppTheme.primary),
                  title: const Text('Publicaciones guardadas'),
                ),
              ),
            ),
            _DarkMode(),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                authService.logOut();
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: AppTheme.primary.withOpacity(0.5)),
                        bottom: BorderSide(
                            color: AppTheme.primary.withOpacity(0.5)))),
                child: ListTile(
                  leading: const Icon(
                    Icons.power_settings_new_rounded,
                    color: Colors.red,
                  ),
                  title: const Text('Cerrar Sesión',
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            )
          ],
        ));
  }
}

class _DarkMode extends StatefulWidget {
  const _DarkMode({
    Key? key,
  }) : super(key: key);

  @override
  State<_DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<_DarkMode> {
  //bool isDarkmode = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppTheme.primary.withOpacity(0.5)))),
      child: SwitchListTile.adaptive(
        title: const Text('Modo oscuro'),
        value: Preferences.isDarkMode,
        onChanged: (value) {
          Preferences.isDarkMode = value;
          final themeProvider =
              Provider.of<ThemeProvider>(context, listen: false);
          value ? themeProvider.setDarkMode() : themeProvider.setLightMode();
          setState(() {});
        },
      ),
    );
  }
}

class _UpperContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _Photo_Followers(userService),

      if (userService.user.nombreDeUsuario != null)
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Text(
            userService.user.nombreDeUsuario!, //
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),

      if (userService.user.descripcion != null)
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Text(userService.user.descripcion!),
        ),

      if (userService.user.link != null)
        Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
            child: GestureDetector(
              child: Text(
                userService.user.link!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Preferences.isDarkMode
                        ? Colors.blue[200]
                        : Colors.blue[900]),
              ),
              onTap: () async {
                launch(userService.user.link!);
              },
            )),

      //TODO: muchas cosas
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                primary: AppTheme.primary,
                side: BorderSide(color: AppTheme.primary)),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text('Editar Perfil'),
            ),
            onPressed: () {
              userService.userEdit = userService.user.copy();
              Navigator.restorablePushNamed(context, 'editProfile');
            }),
      )
    ]);
  }
}

class _Photo_Followers extends StatelessWidget {
  final UserService userService;
  const _Photo_Followers(this.userService);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[400],
              child: userService.user.fotoDePerfil == null
                  ? Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    )
                  : FadeInImage(
                      placeholder: AssetImage('assets/icon.png'),
                      image: NetworkImage(userService.user.fotoDePerfil!)),
            ),
            SizedBox(
              width: 30,
            ),
            _numbers(number: userService.user.nposts, msg: 'Posts'),
            SizedBox(
              width: 15,
            ),
            _numbers(number: userService.user.nseguidores, msg: 'Seguidores'),
            SizedBox(
              width: 15,
            ),
            _numbers(number: userService.user.nsiguiendo, msg: 'Siguiendo')
          ],
        ));
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
              print(value);
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
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent:
                            MediaQuery.of(context).size.width * 0.7),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int indx) {
                      return ArticleCover();
                    },
                  ),
                )
              : Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int indx) {
                        return RecommendationPost();
                      }),
                );
        })
      ],
    );
  }
}
