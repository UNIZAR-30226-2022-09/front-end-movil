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
        body: Column(
          children: [_Description(descripcion: arguments['descripcion'])],
        )

        //Center(child: Text(arguments['descripcion'])),
        );
  }
}

class _Description extends StatelessWidget {
  String? descripcion;
  _Description({Key? key, this.descripcion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return descripcion != null
        ? Container(
            width: double.infinity,
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  descripcion!,
                  style: TextStyle(fontSize: 16),
                )),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: AppTheme.primary.withOpacity(0.5)))),
          )
        : Container();
  }
}
