import 'dart:io';

import 'package:alejandria/models/models.dart';
import 'package:alejandria/provider/provider.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserService userService = Provider.of<UserService>(context);
    if (userService.isLoading)
      return Container(
        height: 300,
        width: double.infinity,
        color: Colors.red,
      );
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Perfil',
              style: TextStyle(
                  color:
                      Preferences.isDarkMode ? Colors.white70 : Colors.black)),
          bottom: BottomLineAppBar(),
          actions: [
            TextButton(
                onPressed: userService.isSaving
                    ? null
                    : () async {
                        final tematicas = Provider.of<TematicasProvider>(
                            context,
                            listen: false);
                        if (!tematicas.checkData()) {
                          NotificationsService.showSnackbar(
                              'Debe elegiir al menos 1 temática');
                          return;
                        }
                        userService.editProfile();

                        Navigator.popUntil(context, (route) => false);
                        Navigator.pushNamed(context, 'tabs');
                      },
                child: Text('Listo',
                    style: TextStyle(
                        color: userService.isSaving
                            ? Colors.grey[600]
                            : AppTheme.primary,
                        fontSize: 16)))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                _ProfilePicture(userService),
                SizedBox(
                  height: 15,
                ),
                Divider(color: AppTheme.primary),
                _ProfileForm(userService.userEdit),
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
                _Tematicas(userService.userEdit.tematicas),
              ],
            ),
          ),
        ));
  }
}

class _ProfilePicture extends StatelessWidget {
  UserService userService;
  _ProfilePicture(this.userService);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(55)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(55),
              child: getProfilePicture(userService.userEdit.fotoDePerfil),
            ),
          ),
          onTap: () async {
            final picker = new ImagePicker();
            final XFile? pickedFile = await picker.pickImage(
                source: ImageSource.gallery, imageQuality: 20);
            if (pickedFile == null) return;
            userService.updateSelectedProfileImage(pickedFile.path);
          },
        ),
        SizedBox(
          height: 5,
        ),
        Text('Toca para cambiar la imagen',
            style: TextStyle(color: AppTheme.primary)),
      ],
    );
  }

  Widget getProfilePicture(String? picture) {
    //No tengo foto
    if (picture == null) {
      print('soy null xd');
      return Icon(Icons.add, size: 50, color: AppTheme.primary);
    }

    //La foto es un link
    else if (picture.startsWith('http')) {
      return FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/icon.png'),
          image: NetworkImage(userService.userEdit.fotoDePerfil!));
    }
    //La foto esta en el dispositivo
    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}

class _ProfileForm extends StatefulWidget {
  UserModel user;

  _ProfileForm(this.user);

  @override
  State<_ProfileForm> createState() => _ProfileFormState(this.user);
}

class _ProfileFormState extends State<_ProfileForm> {
  UserModel userEdit;

  _ProfileFormState(this.userEdit);

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
            initialValue: userEdit.nombreDeUsuario,
            onChanged: (value) => userEdit.nombreDeUsuario = value,
          ),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
            icon: Icons.description_outlined,
            placeholder: 'Descripción',
            maxlines: 3,
            initialValue: userEdit.descripcion,
            onChanged: (value) => userEdit.descripcion = value,
          ),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
            icon: Icons.link_rounded,
            placeholder: 'link',
            initialValue: userEdit.link,
            onChanged: (value) => userEdit.link = value,
          ),
        ]),
      ),
    );
  }
}

class _Tematicas extends StatefulWidget {
  List<String> tematicas;
  _Tematicas(this.tematicas);

  @override
  State<_Tematicas> createState() => _TematicasState();
}

class _TematicasState extends State<_Tematicas> {
  _TematicasState();

  @override
  Widget build(BuildContext context) {
    final tematicas = Provider.of<TematicasProvider>(context).tematicas;

    for (int i = 0; i < widget.tematicas.length; i++) {
      int index = tematicas
          .indexWhere((element) => element.dbName == widget.tematicas[i]);
      tematicas[index].isSelected = true;
    }

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
            return tematicaWidget(
              index: index + 1,
              icon: tematicas[index + 1].icon,
              name: tematicas[index + 1].name,
              list: widget.tematicas,
            );
          }),
    );
  }
}
