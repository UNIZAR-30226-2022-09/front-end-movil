import 'package:alejandria/provider/theme_provider.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/article_cover.dart';
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
                fontSize: 25,
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
        child: Column(
      //physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 50,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: AppTheme.primary.withOpacity(0.5)),
                  bottom:
                      BorderSide(color: AppTheme.primary.withOpacity(0.5)))),
          child: ListTile(
            leading: Icon(Icons.save, color: AppTheme.primary),
            title: const Text('Publicaciones guardadas'),
          ),
        ),
        _DarkMode(),
        Expanded(child: Container()),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: AppTheme.primary.withOpacity(0.5)),
                  bottom:
                      BorderSide(color: AppTheme.primary.withOpacity(0.5)))),
          child: ListTile(
            leading: const Icon(
              Icons.power_settings_new_rounded,
              color: Colors.red,
            ),
            title: const Text('Cerrar Sesión',
                style: TextStyle(color: Colors.red)),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _Photo_Followers(),

      //TODO: coomprobar si ha rellenado el campo "nombre"
      Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 10),
        child: Text(
          'Nombre del usuario',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),

      ///TODO: coomprobar si ha rellenado el campo "descripción"
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Text(
            'Mostrar la descripción provista por el usuario en la pantalla de "editar perfil"'),
      ),

      //TODO: coomprobar si ha rellenado el campo "LINK"
      Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
          child: GestureDetector(
            child: Text(
              'https://github.com/UNIZAR-30226-2022-09/front-end-movil',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Preferences.isDarkMode
                      ? Colors.blue[200]
                      : Colors.blue[900]),
            ),
            onTap: () async {
              launch("https://github.com/UNIZAR-30226-2022-09/front-end-movil");
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
              Navigator.restorablePushNamed(context, 'editProfile');
            }),
      )
    ]);
  }
}

class _Photo_Followers extends StatelessWidget {
  const _Photo_Followers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        //color: Colors.green,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[400],
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            _numbers(number: 10, msg: 'Posts'),
            SizedBox(
              width: 15,
            ),
            _numbers(number: 235, msg: 'Seguidores'),
            SizedBox(
              width: 15,
            ),
            _numbers(number: 176, msg: 'Siguiendo')
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

class _PostsState extends State<_Posts> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: TabBar(
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
        Container(
          width: double.infinity,
          //Luego sustituir 5 y 10, por itemCoount/2 e itemCount
          height: _tabController.index == 0
              ? MediaQuery.of(context).size.width * 0.7 * 5
              : 152 * 10,
          child: TabBarView(controller: _tabController, children: [
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                mainAxisExtent: MediaQuery.of(context).size.width * 0.7,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int indx) {
                return ArticleCover();
              },
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int indx) {
                  return Post(
                    type: 1,
                  );
                }),
          ]),
        ),
      ],
    );
  }
}
