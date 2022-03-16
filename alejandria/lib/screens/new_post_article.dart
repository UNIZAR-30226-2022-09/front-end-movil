import 'package:alejandria/provider/provider.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/tematica2.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewArticleScreen extends StatelessWidget {
  const NewArticleScreen({Key? key}) : super(key: key);

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
                _SelectPdf(),
                Divider(
                  color: AppTheme.primary,
                ),
                _Form(),
                Divider(
                  color: AppTheme.primary,
                ),
                Text(
                  'Temática(s) del artículo',
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

class _SelectPdf extends StatelessWidget {
  const _SelectPdf({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Container con la portada del pdf
        Container(
          width: 110,
          height: 155.57,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          child: Icon(
            Icons.add,
            size: 50,
            color: AppTheme.primary,
          ),
        ),
        //Checkboxes
        _CheckBoxes()
      ],
    );
  }
}

class _CheckBoxes extends StatefulWidget {
  _CheckBoxes({
    Key? key,
  }) : super(key: key);

  @override
  State<_CheckBoxes> createState() => _CheckBoxesState();
}

class _CheckBoxesState extends State<_CheckBoxes> {
  bool checkedValue1 = false;

  bool checkedValue2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155.57,
      width: MediaQuery.of(context).size.width - 110 - 30,
      child: Column(
        children: [
          CheckboxListTile(
              value: checkedValue1,
              title: Text(
                'Certifico que yo soy el autor del artículo',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
              ),
              onChanged: (value) {
                checkedValue1 = !checkedValue1;
                setState(() {});
              }),
          CheckboxListTile(
              value: checkedValue2,
              title: Text(
                'He comprendido que al publicar el artículo cualquier usuario de la plataforma podrá verlo',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
              ),
              onChanged: (value) {
                checkedValue2 = !checkedValue2;
                setState(() {});
              })
        ],
      ),
    );
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
  final descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: CustomInputField(
            icon: Icons.description,
            placeholder: 'Breve descripción del artículo',
            maxlines: 3,
            textController: descriptionCtrl));
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
