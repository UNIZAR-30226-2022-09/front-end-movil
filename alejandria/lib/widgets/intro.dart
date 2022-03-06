import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

class Introduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [_BackgroundImage(), _MainContent()]);
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        child: const Image(
          width: double.infinity,
          height: double.infinity,
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover,
        ));
  }
}

class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Center(
            child: Container(
                padding: EdgeInsets.all(5),
                width: size.width * 0.8,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/no-background-icon.png'),
                      width: size.width * 0.4,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Bienvenido a ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        Text('ALEJANDRÍA',
                            style: TextStyle(
                                fontFamily: 'Amazing Grotesc Ultra',
                                fontSize: 20,
                                color: AppTheme.primary))
                      ],
                    ),
                    SizedBox(height: 5),
                    Text('La red social del conocimiento',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400)),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Comparte tu trabajo con nuestra comunidad de usuarios, recomienda los estudios de otros autores, crea nuevos contactos y explora un sin fin de  publicaciones.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                )),
          ),
          Expanded(child: Container()),
          const Icon(Icons.keyboard_arrow_down,
              size: 120, color: AppTheme.primary)
        ],
      ),
    );
  }
}
