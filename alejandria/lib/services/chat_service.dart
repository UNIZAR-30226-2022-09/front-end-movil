
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:alejandria/models/models.dart';





class ChatService with ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';

  final storage = new FlutterSecureStorage();

  late UserModel usuarioPara;


  Future <List<String>> getListaChats (String usuario) async{
    final url = Uri.http(_baseUrl, '/chat');

      final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'current_user': 'Alvaro'
       });

    //final lista = await json.decode(json.encode(resp.body));

    List<String> lista = (jsonDecode(resp.body).cast<String>());
    return lista;
  }



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

