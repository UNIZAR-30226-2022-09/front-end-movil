import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/labels.dart';
import 'package:flutter/material.dart';

import 'package:alejandria/widgets/widgets.dart';
import 'package:alejandria/widgets/custom_input_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Object? parametro = ModalRoute.of(context)!.settings.arguments;

    bool showLogin = parametro == null ? false : true;
    print(showLogin);

    return Scaffold(
        body: Container(
      color: Color.fromRGBO(244, 241, 234, 1),
      child: PageView(
        scrollDirection: Axis.vertical,
        reverse: showLogin ? true : false,
        children:
            showLogin ? [_Login(), Introduction()] : [Introduction(), _Login()],
      ),
    ));
  }
}

class _Login extends StatelessWidget {
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
                ruta: 'register',
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
              textController: emailCtrl),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
            icon: Icons.lock_outline_rounded,
            placeholder: 'contraseña',
            textController: passCtrl,
            keyboardType: TextInputType.text,
            isPassword: true,
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: AppTheme.primary,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(color: Colors.white),
                )),
            onPressed: () {},
          )
        ]));
  }
}
