import 'package:alejandria/models/tematica_model.dart';
import 'package:alejandria/provider/tematicas_provider.dart';
import 'package:alejandria/search/search_delegate.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({Key? key}) : super(key: key);

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
            _Header(),
            Container(
              width: double.infinity,
              height: 0.5,
              color: AppTheme.primary,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
              child: Text(
                'Novedades',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            CardSwiper(),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10, top: 25),
              child: Text(
                'Populares',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: MediaQuery.of(context).size.width * 0.43),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int indx) {
                    return ArticleCover2();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

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
        if (_isVisible) _FadeInOut()
      ],
    );
  }
}

// class _FadeInOut extends StatelessWidget {
//   const _FadeInOut({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 60,
//       color: Colors.red,
//     );
//   }
// }

class _FadeInOut extends StatelessWidget {
  const _FadeInOut({
    Key? key,
  }) : super(key: key);

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
              onPressed: () {},
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
      onTap: () {
        final tematicas =
            Provider.of<TematicasProvider>(context, listen: false);
        tematicas.selectedTematica = tematica.name;
      },
      child: Container(
        width: 45,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (tematicaProvider.selectedTemaTica == this.tematica.name)
              ? null
              : Colors.grey[300],
          gradient: (tematicaProvider.selectedTemaTica == this.tematica.name)
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.9)])
              : null,
        ),
        child: Icon(
          tematica.icon,
          color: (tematicaProvider.selectedTemaTica == this.tematica.name)
              ? Colors.white
              : AppTheme.primary,
        ),
      ),
    );
  }
}
