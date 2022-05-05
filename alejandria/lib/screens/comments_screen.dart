import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

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
                descripcion: arguments['descripcion'],
                imagePath: arguments['foto_de_perfil_user'],
              ),
              Expanded(
                child: Container(),
              ),
              _WriteComment(),
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

class _WriteComment extends StatefulWidget {
  const _WriteComment({
    Key? key,
  }) : super(key: key);

  @override
  State<_WriteComment> createState() => _WriteCommentState();
}

class _WriteCommentState extends State<_WriteComment> {
  String myComment = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          onChanged: (value) {
            myComment = value;
            print(myComment);
            setState(() {});
          },
          decoration: InputDecoration(
              hintText: 'Escribe un comentario',
              suffix: GestureDetector(
                onTap: myComment.length == 0
                    ? null
                    : () {
                        //TODO: hacer post del comentario
                        print('hola');
                      },
                child: Text(
                  'Publicar',
                  style: TextStyle(
                      color: myComment.length == 0
                          ? AppTheme.primary.withOpacity(0.5)
                          : AppTheme.primary),
                ),
              )),
        ));
  }
}

class _Description extends StatelessWidget {
  String? descripcion;
  String imagePath;
  _Description({Key? key, this.descripcion, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    descripcion =
        "Lorem ipsum nostrud amet qui. Do eiusmod pariatur mollit adipisicing ullamco sint eiusmod fugiat anim labore. Dolore anim occaecat cupidatat sit tempor nisi. Sint eu aliquip et nulla est ea excepteur adipisicing elit exercitation officia. Ullamco nostrud sunt est amet proident.";
    return descripcion != null
        ? Container(
            width: double.infinity,
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: FadeInImage(
                                fit: BoxFit.cover,
                                placeholder: AssetImage('assets/icon.png'),
                                image: NetworkImage(imagePath))),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        descripcion!,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                )),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: AppTheme.primary.withOpacity(0.5)))),
          )
        : Container();
  }
}
