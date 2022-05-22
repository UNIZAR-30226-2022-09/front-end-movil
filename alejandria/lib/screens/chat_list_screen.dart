import 'dart:convert';

import 'package:alejandria/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/user_model.dart';
import '../services/services.dart';
import '../themes/app_theme.dart';
import 'package:http/http.dart' as http;


class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreen createState() => _ChatListScreen();
}

class _ChatListScreen extends State<ChatListScreen>{

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<UserModel> usuarios = [];

  /*final usuarios = [
    UserModel(nick: 'pedro', nposts: 0, nseguidores: 0, nsiguiendo: 0, tematicas: []),
    UserModel(nick: 'juan', nposts: 0, nseguidores: 0, nsiguiendo: 0, tematicas: []),
    UserModel(nick: 'luis', nposts: 0, nseguidores: 0, nsiguiendo: 0, tematicas: []),
  ];*/

  @override
  void initState() {
    this._cargarChats();
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('ALEJANDRÍA',
            style: TextStyle(
                fontFamily: 'Amazing Grotesc Ultra',
                fontSize: 30,
                color: AppTheme.primary)
        ),            
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarChats,
        header: WaterDropHeader(
          waterDropColor: AppTheme.primary,
        ),
        child: _listViewChats(),
      )
    );
  }

  ListView _listViewChats() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _chatListTitle(usuarios[i]),
      separatorBuilder: (_, i) => Divider(), 
      itemCount: usuarios.length,
    );
  }

  ListTile _chatListTitle(UserModel usuario) {
    return ListTile(
        title: Text(usuario.nick),
        leading: CircleAvatar(
          backgroundColor: AppTheme.primary,
          child:  usuario.fotoDePerfil == null
                  ? Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.white,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/icon.png'),
                          image:  NetworkImage(usuario.fotoDePerfil!)),
                    ),
        ),
        onTap: (){
          /*
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.usuarioPara = usuario;
          Navigator.pushNamed(context, 'chat');*/
        },
      );
  }

  _cargarChats() async {
    usuarios.clear();
    final userService = new UserService();
    final chatService = new ChatService();

    var lista = await chatService.getListaChats(Preferences.userNick);
    print(lista);

    for(var user in lista){
      UserModel usuario = await userService.loadOtherUser(user);
      usuarios.add(usuario);
    }

    setState(() {

    });
    //await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}