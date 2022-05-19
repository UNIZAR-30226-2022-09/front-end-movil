import 'dart:io';

import 'package:alejandria/models/post_model.dart';
import 'package:alejandria/provider/provider.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class NewArticleScreen extends StatelessWidget {
  const NewArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostService articlePost = Provider.of<PostService>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Nuevo post',
              style: TextStyle(
                  color:
                      Preferences.isDarkMode ? Colors.white70 : Colors.black)),
          bottom: BottomLineAppBar(),
          actions: [
            TextButton(
                onPressed: articlePost.isSaving
                    ? null
                    : () async {
                        final tematicas = Provider.of<TematicasProvider>(
                            context,
                            listen: false);
                        if (articlePost.pdfArticle == null) {
                          NotificationsService.showSnackbar(
                              'Seleccione un archivo pdf');
                          return;
                        }
                        if (!tematicas.checkData()) {
                          NotificationsService.showSnackbar(
                              'Debe elegiir al menos 1 temática');
                          return;
                        } else if (!(articlePost.check1 &&
                            articlePost.check2)) {
                          NotificationsService.showSnackbar(
                              'Marca las casillas por favor');
                          return;
                        }

                        articlePost.uploadPost();
                        final postsService =
                            Provider.of<MyPostsService>(context, listen: false);
                        final userService =
                            Provider.of<UserService>(context, listen: false);
                        await postsService.loadArticles(Preferences.userNick);
                        userService.user.nposts += 1;

                        Navigator.popUntil(context, (route) => false);
                        Navigator.pushNamed(context, 'tabs');
                      },
                child: Text('Publicar',
                    style: TextStyle(
                        color: articlePost.isSaving
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
                _SelectPdf(articlePost),
                Divider(
                  color: AppTheme.primary,
                ),
                _Form(articlePost.newPost),
                Divider(
                  color: AppTheme.primary,
                ),
                Text(
                  'Temática(s) del artículo',
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                _Tematicas(articlePost)
              ],
            ),
          ),
        ));
  }
}

class _SelectPdf extends StatelessWidget {
  PostService articlePost;
  _SelectPdf(this.articlePost);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Container con la portada del pdf
        GestureDetector(
          onTap: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            if (result == null) return;
            articlePost.pdfArticle = File(result.files.single.path!);
            articlePost.notify();
          },
          child: Container(
            width: 110,
            height: 155.57,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10)),
            child: articlePost.pdfArticle == null
                ? Icon(
                    Icons.add,
                    size: 50,
                    color: AppTheme.primary,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SfPdfViewer.file(
                      articlePost.pdfArticle!,
                      canShowScrollHead: false,
                      enableDoubleTapZooming: false,
                      enableTextSelection: false,
                    ),
                  ),
          ),
        ),
        //Checkboxes
        _CheckBoxes(articlePost)
      ],
    );
  }
}

class _CheckBoxes extends StatelessWidget {
  PostService articlePost;
  _CheckBoxes(this.articlePost);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155.57,
      width: MediaQuery.of(context).size.width - 110 - 30,
      child: Column(
        children: [
          CheckboxListTile(
              value: articlePost.check1,
              title: Text(
                'Certifico que yo soy el autor del artículo',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
              ),
              onChanged: (value) {
                articlePost.check1 = !articlePost.check1;
                articlePost.notify();
              }),
          CheckboxListTile(
              value: articlePost.check2,
              title: Text(
                'He comprendido que al publicar el artículo cualquier usuario de la plataforma podrá verlo',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
              ),
              onChanged: (value) {
                articlePost.check2 = !articlePost.check2;
                articlePost.notify();
              })
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  PostModel post;
  _Form(this.post);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: CustomInputField(
            icon: Icons.description,
            placeholder: 'Breve descripción del artículo',
            maxLength: 100,
            maxlines: 3,
            onChanged: (value) => widget.post.descripcion = value));
  }
}

class _Tematicas extends StatelessWidget {
  PostService articlePost;
  _Tematicas(this.articlePost);

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
                list: articlePost.newPost.tematicas);
          }),
    );
  }
}
