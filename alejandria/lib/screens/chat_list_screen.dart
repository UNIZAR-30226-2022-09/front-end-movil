import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:alejandria/share_preferences/preferences.dart';
import '../models/user_model.dart';
import '../services/services.dart';
import '../themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';


class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreen createState() => _ChatListScreen();
}

class _ChatListScreen extends State<ChatListScreen>{
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<UserModel> usuarios = [];

    Future? myFuture;

  @override
  void initState() {
    myFuture = _cargarChats();
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
      body: FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppTheme.primary,
              )
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return SmartRefresher(
              controller: _refreshController,
            enablePullDown: true,
            onRefresh: _cargarChats,
            header: WaterDropHeader(
              waterDropColor: AppTheme.primary,
            ),
            child: usuarios.length != 0
              ? _listViewChats()
              : Center(
                  child: NoPosts(
                    'Habla con usuarios para ver los chats',
                    FontAwesomeIcons.solidMessage),
                )
              );
          }
          return Container();

        },
      ),
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
    final chatService = Provider.of<ChatService>(context, listen: false);

    return ListTile(
        title: Text(usuario.nick),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
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
        onTap: () async {
          chatService.usuarioPara = usuario;
          chatService.sala = await chatService.entrarChat(Preferences.userNick, usuario.nick);
          Navigator.pushNamed(context, 'chat');
        },
      );
  }

  _cargarChats() async {
    usuarios.clear();
    final userService = new UserService();
    final chatService = new ChatService();

    var lista = await chatService.getListaChats(Preferences.userNick);

    for(var user in lista){
      UserModel usuario = await userService.loadOtherUser(user);
      usuarios.add(usuario);
    }

    setState(() {

    });
    _refreshController.refreshCompleted();
  }

}