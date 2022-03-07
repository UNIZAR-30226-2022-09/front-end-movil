import 'package:alejandria/models/tematica_model.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Crear Perfil', style: TextStyle(color: Colors.black)),
          bottom: BottomLineAppBar(),
          actions: [
            TextButton(
                onPressed: () {},
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
                _ProfiilePicture(),
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
                _Tematicas(),
              ],
            ),
          ),
        ));
  }
}

class _ProfiilePicture extends StatelessWidget {
  const _ProfiilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: Colors.grey[300],
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

class _Tematicas extends StatelessWidget {
  const _Tematicas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Temáticas de interes',
          style: TextStyle(
              color: AppTheme.primary,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
