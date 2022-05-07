import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/screens/una_prueba.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:alejandria/screens/una_prueba.dart';

class ArticleCover2 extends StatelessWidget {
  PostListModel? post;
  ArticleCover2({Key? key, this.post}) : super(key: key);

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
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[400],
                child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.contain,
                    placeholder: AssetImage('assets/carga.jpg'),
                    image: AssetImage('assets/carga.jpg')
                    //image: NetworkImage(post.portada!)
                    ),
              ),
            ),
            // Container(
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.pushNamed(context, 'onePost',
            //           arguments: {'post': post});
            //     },
            //   ),
            // )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
