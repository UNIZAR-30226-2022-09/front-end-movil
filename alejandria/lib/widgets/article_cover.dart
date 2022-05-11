import 'package:alejandria/models/post_list_model.dart';
import 'package:alejandria/screens/una_prueba.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleCover extends StatelessWidget {
  PostListModel post;
  int dondeVoy;
  ArticleCover({Key? key, required this.post, required this.dondeVoy})
      : super(key: key);

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
                child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.contain,
                    placeholder: AssetImage('assets/carga.jpg'),
                    //image: AssetImage('assets/carga.jpg')
                    image: NetworkImage(post.portada!)),
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  if (dondeVoy == 1) {
                    final prueba =
                        Provider.of<PruebaProvider>(context, listen: false);
                    prueba.changeScreen(false, post);
                  } else {
                    Navigator.pushNamed(context, 'onePost',
                        arguments: {'post': post});
                  }
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
