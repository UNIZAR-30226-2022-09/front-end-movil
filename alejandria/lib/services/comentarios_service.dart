import 'dart:convert';

import 'package:alejandria/models/models.dart';
import 'package:alejandria/screens/comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ComentariosService extends ChangeNotifier {
  List<ComentraioModel> comentarios = [];

  final storage = new FlutterSecureStorage();

  Future<List<ComentraioModel>> cargarComentarios(String id) async {
    comentarios = [];
    final url = Uri.http('51.255.50.207:5000', '/verComentarios');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'id': id
    });
    final Map<String, dynamic> commentsMap = json.decode(resp.body);
    commentsMap.forEach((key, value) {
      comentarios.add(ComentraioModel.fromMap(value));
    });
    return comentarios;
  }

  Future<void> subirComentario(String id, String comentario) async {
    final url = Uri.http('51.255.50.207:5000', '/comentar');
    await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await storage.read(key: 'token') ?? ''
        },
        body:
            json.encode(<String, dynamic>{'id': id, 'comentario': comentario}));
    this.cargarComentarios(id);
    notifyListeners();
  }
}
