import 'package:alejandria/models/tematica_model.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Perfil',
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
                child: Text('Listo',
                    style: TextStyle(color: AppTheme.primary, fontSize: 16)))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                _ProfilePicture(),
                SizedBox(
                  height: 15,
                ),
                Divider(color: AppTheme.primary),
                _ProfileForm(),
                SizedBox(
                  height: 15,
                ),
                Divider(color: AppTheme.primary),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Temáticas de interes',
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                _Tematicas(),
              ],
            ),
          ),
        ));
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor:
              Preferences.isDarkMode ? Colors.grey[400] : Colors.grey[300],
          //TODO: si tiene imagen sustituir el child por un NetworkImage
          child: Icon(Icons.add, size: 50, color: AppTheme.primary),
        ),
        SizedBox(
          height: 5,
        ),
        Text('Toca para cambiar la imagen',
            style: TextStyle(color: AppTheme.primary)),
      ],
    );
  }
}

class _ProfileForm extends StatefulWidget {
  const _ProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<_ProfileForm> {
  final nameCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final linkCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        child: Column(children: [
          CustomInputField(
              icon: Icons.person_outline_rounded,
              placeholder: 'Nombre',
              textController: nameCtrl),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
              icon: Icons.description_outlined,
              placeholder: 'Descripción',
              maxlines: 3,
              textController: descriptionCtrl),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
              icon: Icons.link_rounded,
              placeholder: 'link',
              textController: linkCtrl),
        ]),
      ),
    );
  }
}

class _Tematicas extends StatefulWidget {
  const _Tematicas({
    Key? key,
  }) : super(key: key);

  @override
  State<_Tematicas> createState() => _TematicasState();
}

class _TematicasState extends State<_Tematicas> {
  @override
  Widget build(BuildContext context) {
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
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return tematicaWidget(
                icon: Tematica.tematicas[index].icon,
                name: Tematica.tematicas[index].name,
                isSelected: Tematica.tematicas[index].isSelected);
          }),
    );
  }
}
