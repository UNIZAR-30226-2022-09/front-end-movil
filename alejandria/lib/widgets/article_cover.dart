import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/screens/una_prueba.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:alejandria/screens/una_prueba.dart';

class ArticleCover extends StatelessWidget {
  PostListModel post;
  ArticleCover({Key? key, required this.post}) : super(key: key);

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
            Hero(
                tag: post.id!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.contain,
                        placeholder: AssetImage('assets/carga.jpg'),
                        //image: AssetImage('assets/carga.jpg')
                        image: NetworkImage(post.portada!)),
                  ),
                )
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //   child: SfPdfViewer.network(
                //     post.pdf!,
                //     canShowScrollHead: false,
                //     enableDoubleTapZooming: false,
                //     enableTextSelection: false,
                //   ),
                // ),
                ),
            Container(
              child: GestureDetector(
                onTap: () {
                  final prueba =
                      Provider.of<PruebaProvider>(context, listen: false);
                  prueba.changeScreen(false, post);

                  // Navigator.pushNamed(context, 'onePost',
                  //     arguments: {'post': post});
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
