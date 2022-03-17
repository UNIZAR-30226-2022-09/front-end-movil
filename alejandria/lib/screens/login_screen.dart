import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:alejandria/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    return Scaffold(
        body: Container(
      color: Color.fromRGBO(244, 241, 234, 1),
      child: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Introduction(),
          PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _Login(pageController: _pageController),
              _Register(pageController: _pageController)
            ],
          )
        ],
      ),
    ));
  }
}

class _Login extends StatelessWidget {
  final PageController pageController;

  const _Login({Key? key, required this.pageController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 241, 234, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(children: [
            Logo(),
            _Form(),
            Expanded(child: Container()),
            Labels(
                pageController: pageController,
                ruta: 1,
                arriba: '¿Todavía no tienes cuenta?',
                abajo: 'Créate una ahora')
          ]),
        ),
      )),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 60),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          CustomInputField(
            icon: Icons.perm_identity_rounded,
            placeholder: 'nombre de usuario o correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
            isIntro: true,
          ),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
            icon: Icons.lock_outline_rounded,
            placeholder: 'contraseña',
            textController: passCtrl,
            keyboardType: TextInputType.text,
            isPassword: true,
            isIntro: true,
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: AppTheme.intro,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(color: Colors.white),
                )),
            onPressed: () {
              //TODO: comprobar que el login es correcto
              Navigator.pushReplacementNamed(context, 'tabs');
            },
          )
        ]));
  }
}

class _Register extends StatelessWidget {
  final PageController pageController;

  const _Register({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 241, 234, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(children: [
            Logo(),
            _FormR(),
            Expanded(child: Container()),
            Labels(
              pageController: pageController,
              ruta: 0,
              arriba: '¿Ya tienes cuenta?',
              abajo: 'Inicia sesión',
              showLogin: true,
            )
          ]),
        ),
      )),
    );
  }
}

class _FormR extends StatefulWidget {
  @override
  State<_FormR> createState() => __FormRState();
}

class __FormRState extends State<_FormR> {
  final userCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 60),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          CustomInputField(
            icon: Icons.perm_identity_rounded,
            placeholder: 'nombre de usuario',
            keyboardType: TextInputType.text,
            textController: userCtrl,
            isIntro: true,
          ),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
            icon: Icons.mail_outline,
            placeholder: 'correo electrónico',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
            isIntro: true,
          ),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
            icon: Icons.lock_outline_rounded,
            placeholder: 'contraseña',
            textController: passCtrl,
            keyboardType: TextInputType.text,
            isPassword: true,
            isIntro: true,
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: AppTheme.intro,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Text(
                  'Crear Cuenta',
                  style: TextStyle(color: Colors.white),
                )),
            onPressed: () {
              //TOODO: comprar que la creación de cuenta es correcta
              Navigator.pushReplacementNamed(context, 'editProfile');
            },
          )
        ]));
  }
}
