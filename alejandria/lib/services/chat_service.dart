
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


  Future <List<String>> getListaChats (String usuario) async{
    final url = Uri.http(_baseUrl, '/chat');

    final resp = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'token': await storage.read(key: 'token') ?? '',
    'current_user': usuario
     });

    List<String> lista = (jsonDecode(resp.body).cast<String>());
    return lista;
  }


  Future <List<Mensaje>> getMensajes (String yo, String otro) async{
    final url = Uri.http(_baseUrl, '/private/'+ otro);
    print(otro);
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'userOrigin': yo
    });

  /*
    final channel = IOWebSocketChannel.connect(
      Uri.parse('ws://51.255.50.207:5000/private/alvaro'),
    );

    channel.sink.add('Hola');

    channel.stream.listen((message) {
      channel.sink.add('received!');
      print(message);
      //channel.sink.close(status.goingAway);
    });

    channel.sink.close();*/


   List<Mensaje> lista = [];
    var jsonresponse = json.decode(resp.body);
    for(var mensaje in jsonresponse){
      lista.add(Mensaje.fromJson(mensaje));
    }

    return lista;
  }

}

