import 'package:alejandria/models/models.dart';
import 'package:alejandria/provider/provider.dart';
import 'package:alejandria/services/services.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserService userService = Provider.of<UserService>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Perfil',
              style: TextStyle(
                  color:
                      Preferences.isDarkMode ? Colors.white70 : Colors.black)),
          bottom: BottomLineAppBar(),
          actions: [
            TextButton(
                onPressed: () async {
                  final tematicas =
                      Provider.of<TematicasProvider>(context, listen: false);
                  if (!tematicas.checkData()) {
                    NotificationsService.showSnackbar(
                        'Debe elegiir al menos 1 temática');
                    return;
                  }

                  userService.editProfile();
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
                _ProfilePicture(userService.userEdit.fotoDePerfil),
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
  final String? url;
  const _ProfilePicture(this.url);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 55,
            backgroundColor:
                Preferences.isDarkMode ? Colors.grey[400] : Colors.grey[300],
            child: url == null
                ? Icon(Icons.add, size: 50, color: AppTheme.primary)
                : FadeInImage(
                    placeholder: AssetImage('assets/icon.png'),
                    image: NetworkImage(url!))),
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
            onChanged: (value) => userEdit.nombreDeUsuario = value,
          ),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
            icon: Icons.description_outlined,
            placeholder: 'Descripción',
            maxlines: 3,
            onChanged: (value) => userEdit.descripcion = value,
          ),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
            icon: Icons.link_rounded,
            placeholder: 'link',
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
  State<_Tematicas> createState() => _TematicasState(tematicas);
}

class _TematicasState extends State<_Tematicas> {
  List<String> tematicasService;
  _TematicasState(this.tematicasService);

  @override
  Widget build(BuildContext context) {
    final tematicas = Provider.of<TematicasProvider>(context).tematicas;

    //inicializo el array de  tematicas
    tematicasService.map((value) {
      int index = tematicas.indexWhere((element) => element.dbName == value);
      tematicas[index].isSelected = true;
    });
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
              list: tematicasService,
            );
          }),
    );
  }
}
