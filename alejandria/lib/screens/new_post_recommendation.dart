import 'package:alejandria/provider/tematicas_provider.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewRecommendationScreen extends StatelessWidget {
  const NewRecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostService recPost = Provider.of<PostService>(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
        appBar: AppBar(
          title: Text('Nuevo post',
              style: TextStyle(
                  color:
                      Preferences.isDarkMode ? Colors.white70 : Colors.black)),
          bottom: BottomLineAppBar(),
          actions: [
            TextButton(
                onPressed: recPost.isSaving
                    ? null
                    : () async {
                        final tematicas = Provider.of<TematicasProvider>(
                            context,
                            listen: false);
                        if (!tematicas.checkData()) {
                          NotificationsService.showSnackbar(
                              'Debe elegiir al menos 1 temática');
                          return;
                        } else if (recPost.newPost.autor == null ||
                            recPost.newPost.titulo == null ||
                            recPost.newPost.autor!.length == 0 ||
                            recPost.newPost.titulo!.length == 0) {
                          NotificationsService.showSnackbar(
                              'Los campos "Título" y "Autor" son obligatorios');
                          return;
                        }

                        recPost.uploadPost();

                        Navigator.popUntil(context, (route) => false);
                        Navigator.pushNamed(context, 'tabs');
                      },
                child: Text('Publicar',
                    style: TextStyle(
                        color: recPost.isSaving
                            ? Colors.grey[600]
                            : AppTheme.primary,
                        fontSize: 16)))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              children: [
                _Form(recPost, arguments['link'], arguments['autor'],
                    arguments['titulo']),
                Divider(
                  color: AppTheme.primary,
                ),
                Text(
                  'Temática(s) de la recomendación',
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                _Tematicas(recPost)
              ],
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  PostService recPost;
  String? link;
  String? autor;
  String? titulo;

  _Form(this.recPost, this.link, this.autor, this.titulo);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  _FormState();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        CustomInputField(
            icon: Icons.description,
            placeholder: 'Nombre del artículo',
            initialValue: widget.titulo,
            maxlines: 1,
            onChanged: (value) => widget.recPost.newPost.titulo = value),
        SizedBox(
          height: 15,
        ),
        CustomInputField(
            icon: Icons.description,
            placeholder: 'Autor del artículo',
            initialValue: widget.autor,
            maxlines: 1,
            onChanged: (value) => widget.recPost.newPost.autor = value),
        SizedBox(
          height: 15,
        ),
        CustomInputField(
            icon: Icons.description,
            placeholder: 'Breve opinióndel artículo',
            maxlines: 3,
            onChanged: (value) => widget.recPost.newPost.descripcion = value),
        SizedBox(
          height: 15,
        ),
        CustomInputField(
            icon: Icons.link_rounded,
            placeholder: 'link al atículo',
            initialValue: widget.link,
            onChanged: (value) => widget.recPost.newPost.link = value),
      ],
    ));
  }
}

class _Tematicas extends StatelessWidget {
  PostService recPost;
  _Tematicas(this.recPost);

  @override
  Widget build(BuildContext context) {
    final tematicas = Provider.of<TematicasProvider>(context).tematicas;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: tematicas.length - 1,
          itemBuilder: (BuildContext context, int index) {
            return tematicaWidget(
                index: index + 1,
                icon: tematicas[index + 1].icon,
                name: tematicas[index + 1].name,
                list: recPost.newPost.tematicas);
          }),
    );
  }
}
