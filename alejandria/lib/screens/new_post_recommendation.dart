import 'package:alejandria/provider/tematicas_provider.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/tematica2.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewRecommendationScreen extends StatelessWidget {
  const NewRecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nuevo post',
              style: TextStyle(
                  color:
                      Preferences.isDarkMode ? Colors.white70 : Colors.black)),
          bottom: BottomLineAppBar(),
          actions: [
            TextButton(
                onPressed: () {
                  //TOODO: guardar los valores
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, 'tabs');
                },
                child: Text('Publicar',
                    style: TextStyle(color: AppTheme.primary, fontSize: 16)))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              children: [
                _Form(),
                Divider(
                  color: AppTheme.primary,
                ),
                Text(
                  'Temática(s) de la recomendación',
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                _Tematicas()
              ],
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
  }) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final titleCtrl = TextEditingController();
  final authorCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final linkCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        CustomInputField(
            icon: Icons.description,
            placeholder: 'Nombre del artículo',
            maxlines: 1,
            textController: titleCtrl),
        SizedBox(
          height: 15,
        ),
        CustomInputField(
            icon: Icons.description,
            placeholder: 'Autor del artículo',
            maxlines: 1,
            textController: authorCtrl),
        SizedBox(
          height: 15,
        ),
        CustomInputField(
            icon: Icons.description,
            placeholder: 'Breve opinióndel artículo',
            maxlines: 3,
            textController: descriptionCtrl),
        SizedBox(
          height: 15,
        ),
        CustomInputField(
            icon: Icons.link_rounded,
            placeholder: 'link al atíiculo',
            textController: linkCtrl),
      ],
    ));
  }
}

class _Tematicas extends StatelessWidget {
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
            return tematicaWidget2(
              index: index + 1,
              icon: tematicas[index + 1].icon,
              name: tematicas[index + 1].name,
            );
          }),
    );
  }
}
