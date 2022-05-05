import 'package:alejandria/models/post_list_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ArticleCover extends StatelessWidget {
  PostListModel? post;
  ArticleCover({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'onePost');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SfPdfViewer.network(
                post != null
                    ? post!.pdf!
                    : 'http://51.255.50.207:5000/display2/Practica2_21_22.pdf',
                canShowScrollHead: false,
                enableDoubleTapZooming: false,
                enableTextSelection: false,
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  print('hola');
                  Navigator.pushNamed(context, 'onePost',
                      arguments: {'post': post});
                },
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
