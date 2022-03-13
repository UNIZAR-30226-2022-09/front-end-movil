import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String arriba;
  final String abajo;
  final bool showLogin;

  const Labels(
      {Key? key,
      required this.ruta,
      required this.arriba,
      required this.abajo,
      this.showLogin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(arriba,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 17,
                fontWeight: FontWeight.w300)),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            showLogin
                ? Navigator.pushReplacementNamed(context, ruta,
                    arguments: {'showLogin': true})
                : Navigator.pushReplacementNamed(context, ruta);
          },
          child: Text(abajo,
              style: TextStyle(
                  color: AppTheme.intro,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        )
      ],
    ));
  }
}
