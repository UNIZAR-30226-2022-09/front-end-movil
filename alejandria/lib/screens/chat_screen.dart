import 'dart:io';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:provider/provider.dart';
import 'package:alejandria/services/chat_service.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../themes/app_theme.dart';

class ChatScreen extends StatefulWidget{

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{


  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  List<ChatMessage> _messages = [ ];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context){
    final chatService = Provider.of<ChatService>(context);
    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
       appBar: AppBar(
        title: Column (
          children: <Widget>[
            CircleAvatar(
              child:   Container(
                  width: 100,
                  height: 100,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/icon.png'),
                      image: NetworkImage(usuarioPara.fotoDePerfil!),
                    ),
                  )),
              maxRadius: 15,
            ),
            SizedBox(height: 3),
            Text(usuarioPara.nick, style: TextStyle(color: AppTheme.primary, fontSize: 12))
          ],
        ),
         bottom: BottomLineAppBar(),
       ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(height: 1,),
            Container (
                child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat(){

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto){
                  setState(() {
                    if(texto.trim().length > 0){
                      _estaEscribiendo = true;
                    }else{
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Enviar mensaje',
                    contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                  isDense: true,
                ),
                focusNode: _focusNode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              )
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: AppTheme.primary),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send),
                    onPressed: _estaEscribiendo
                      ? () => _handleSubmit(_textController.text.trim())
                      : null,
                  ),
                ),
              ),
            )
        ]),
      )
    );
  }


  _handleSubmit(String texto){
    if(texto.length == 0) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      texto: texto, 
      nick: Preferences.userNick,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });

    /*
    this.socketService.emit('mensaje', {
      'sala': ,
      'de': Preferences.userNick,
      'para': this.chatService.usuarioPara.nick,
      'mensaje': texto
    });*/

  }

  @override
  void dispose() {
    //TODO: off del socket

    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    
    super.dispose();
  }
}