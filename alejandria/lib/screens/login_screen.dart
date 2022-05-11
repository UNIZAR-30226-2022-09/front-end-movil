import 'package:alejandria/models/user_model.dart';
import 'package:alejandria/provider/provider.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:alejandria/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/login_form_provider.dart';

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
          ChangeNotifierProvider(
            create: (_) => LoginFormProvider(),
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _Login(pageController: _pageController),
                _Register(pageController: _pageController)
              ],
            ),
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
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
        margin: const EdgeInsets.only(top: 60),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: loginForm.loginFormKey,
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(children: [
            CustomInputField(
              icon: Icons.perm_identity_rounded,
              placeholder: 'nombre de usuario o correo',
              keyboardType: TextInputType.emailAddress,
              isIntro: true,
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                String pattern2 = r'[a-z0-9._]{3,15}$';

                if (value != null && value.contains('@')) {
                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value) ? null : 'Formato incorrecto';
                } else {
                  RegExp regExp = new RegExp(pattern2);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Formato incorrecto';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomInputField(
              icon: Icons.lock_outline_rounded,
              placeholder: 'contraseña',
              keyboardType: TextInputType.text,
              isPassword: true,
              isIntro: true,
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return value != null && value.length > 7
                    ? null
                    : 'Contraseña muy corta (mínimo 8 caracteres)';
              },
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: AppTheme.intro,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(color: Colors.white),
                  )),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidLoginForm()) return;

                      loginForm.isLoading = true;

                      // TODO: validar si el login es correcto
                      final String? errorMessage = await authService
                          .validateUser(loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'tabs');
                        final userService =
                            Provider.of<UserService>(context, listen: false);
                        await userService.loadData(Preferences.userNick);
                        final postsService =
                            Provider.of<MyPostsService>(context, listen: false);
                        await postsService.loadRecs(Preferences.userNick);
                        await postsService.loadArticles(Preferences.userNick);
                      } else {
                        NotificationsService.showSnackbar(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
            )
          ]),
        ));
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
  @override
  Widget build(BuildContext context) {
    final regsiterForm = Provider.of<LoginFormProvider>(context);
    return Container(
        margin: const EdgeInsets.only(top: 60),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: regsiterForm.registerFormKey,
          child: Column(children: [
            CustomInputField(
              icon: Icons.perm_identity_rounded,
              placeholder: 'nombre de usuario',
              keyboardType: TextInputType.text,
              isIntro: true,
              onChanged: (value) => regsiterForm.nick = value,
              validator: (value) {
                String pattern = r'[a-z0-9._]{3,15}$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato de nombre de usuario incorrecto';
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomInputField(
              icon: Icons.mail_outline,
              placeholder: 'correo electrónico',
              keyboardType: TextInputType.emailAddress,
              isIntro: true,
              onChanged: (value) => regsiterForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato de correo electrrónico incorecto';
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomInputField(
              icon: Icons.lock_outline_rounded,
              placeholder: 'contraseña',
              keyboardType: TextInputType.text,
              isPassword: true,
              isIntro: true,
              onChanged: (value) => regsiterForm.password = value,
              validator: (value) {
                return (value != null && value.length > 7)
                    ? null
                    : 'Contraseña muy corta (mínimo 8 caracteres)';
              },
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: AppTheme.intro,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: Text(
                    'Crear Cuenta',
                    style: TextStyle(color: Colors.white),
                  )),
              onPressed: regsiterForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!regsiterForm.isValidRegisterForm()) return;

                      regsiterForm.isLoading = true;

                      final String? errorMessage = await authService.createUser(
                          regsiterForm.nick,
                          regsiterForm.email,
                          regsiterForm.password);

                      if (errorMessage == null) {
                        final userService =
                            Provider.of<UserService>(context, listen: false);
                        userService.userEdit =
                            await userService.loadData(regsiterForm.nick);
                        final postsService =
                            Provider.of<MyPostsService>(context, listen: false);
                        await postsService.loadRecs(Preferences.userNick);
                        await postsService.loadArticles(Preferences.userNick);

                        final tematicasProvider =
                            Provider.of<TematicasProvider>(context,
                                listen: false);
                        tematicasProvider.resetData();
                        Navigator.pushReplacementNamed(context, 'editProfile');
                      } else {
                        NotificationsService.showSnackbar(errorMessage);
                        regsiterForm.isLoading = false;
                      }
                    },
            )
          ]),
        ));
  }
}
