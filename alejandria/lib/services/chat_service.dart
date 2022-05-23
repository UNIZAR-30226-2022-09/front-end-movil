
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:alejandria/models/models.dart';


class ChatService with ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';

  final storage = new FlutterSecureStorage();

  late UserModel usuarioPara;
  late String sala;
  List<String> listaChats = [];

  Future <List<String>> getListaChats (String usuario) async{
    listaChats = [];
    final url = Uri.http(_baseUrl, '/chat');

    final resp = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'token': await storage.read(key: 'token') ?? '',
    'current_user': usuario
     });

    listaChats = (jsonDecode(resp.body).cast<String>());
    return listaChats;
  }


  Future <List<Mensaje>> getMensajes (String room) async{
    final url = Uri.http(_baseUrl, '/private/'+ room);
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
    });

   List<Mensaje> lista = [];
    var jsonresponse = json.decode(resp.body);
    for(var mensaje in jsonresponse){
      lista.add(Mensaje.fromJson(mensaje));
    }

    return lista;
  }

  Future<String> entrarChat (String yo, String otro) async{
    final url = Uri.http(_baseUrl, '/new_chat');

    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'userOrigin': yo,
      'userDest': otro,

    });

    print(resp.body);

    return  json.decode(resp.body).toString();
  }





}

