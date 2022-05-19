import 'package:alejandria/models/models.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  List<ComentraioModel> comentarios = [];
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    PostListModel post = arguments['post'];

    return Scaffold(
        appBar: AppBar(
          title: Text('Comentarios',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary)),
          bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _Description(
                descripcion: post.descripcion,
                imagePath: post.fotoDePerfil,
              ),
              _VerComentarios(post.id!),
              SizedBox(
                height: 5,
              ),
              _WriteComment(post),
              SizedBox(
                height: 2,
              )
            ],
          ),
        )

        //Center(child: Text(arguments['descripcion'])),
        );
  }
}

class _VerComentarios extends StatelessWidget {
  final String id;
  _VerComentarios(this.id);

  @override
  Widget build(BuildContext context) {
    final myService = Provider.of<ComentariosService>(context);
    Future<void> getComments() async {
      await myService.cargarComentarios(id);
    }

    return Expanded(
      child: FutureBuilder(
          future: getComments(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: AppTheme.primary));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: myService.comentarios.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        index == myService.comentarios.length - 1
                            ? Container(
                                width: double.infinity,
                                height: 0.5,
                                color: AppTheme.primary)
                            : Container(),
                        Comentario(myService.comentarios[index]),
                        Container(
                            width: double.infinity,
                            height: 0.5,
                            color: AppTheme.primary),
                      ],
                    );
                  });
            }
            return Container();
          }),
    );
  }
}

class Comentario extends StatelessWidget {
  final ComentraioModel comentario;

  Comentario(this.comentario);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/icon.png'),
                image: NetworkImage(comentario.fotoDePerfil))),
      ),
      title: Text('@${comentario.nick}',
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(comentario.comentario,
          style: TextStyle(
              color: Preferences.isDarkMode ? Colors.white : Colors.black)),
    );
  }
}

class _WriteComment extends StatefulWidget {
  final PostListModel post;
  _WriteComment(this.post);

  @override
  State<_WriteComment> createState() => _WriteCommentState();
}

class _WriteCommentState extends State<_WriteComment> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          controller: _controller,
          onChanged: (value) {
            if (value.length == 0 || value.length == 1) setState(() {});
          },
          decoration: InputDecoration(
              hintText: 'Escribe un comentario',
              suffix: GestureDetector(
                onTap: _controller.text.length == 0
                    ? null
                    : () async {
                        final subirC = Provider.of<ComentariosService>(context,
                            listen: false);
                        subirC.subirComentario(
                            widget.post.id!, _controller.text);
                        _controller.clear();
                        widget.post.ncomentarios += 1;
                        final articlesService =
                            Provider.of<MyPostsService>(context, listen: false);
                        articlesService.notifyListeners();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                child: Text(
                  'Publicar',
                  style: TextStyle(
                      color: _controller.text.length == 0
                          ? AppTheme.primary.withOpacity(0.5)
                          : AppTheme.primary),
                ),
              )),
        ));
  }
}

class _Description extends StatelessWidget {
  final String? descripcion;
  final String imagePath;
  _Description({Key? key, this.descripcion, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return descripcion != null
        ? ListTile(
            shape: Border(bottom: BorderSide(color: AppTheme.primary)),
            leading: Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/icon.png'),
                      image: NetworkImage(imagePath))),
            ),
            title: Text(
              descripcion!,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ))
        : Container();
  }
}
