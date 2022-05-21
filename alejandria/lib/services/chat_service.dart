
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:alejandria/models/models.dart';





class ChatService with ChangeNotifier {

  late UserModel usuarioPara;


  /*Future<List<Mensaje>> getChat( String usuarioID ) async {

    final resp = await http.get('${ Environment.apiUrl }/mensajes/$usuarioID',
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      }
    );

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;


  }*/



}

