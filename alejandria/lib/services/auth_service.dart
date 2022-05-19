import 'dart:convert';

import 'package:alejandria/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';

  final storage = new FlutterSecureStorage();

  Future<String?> createUser(
      String nick, String e_mail, String password) async {
    final url = Uri.http(_baseUrl, '/register');

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          'nick': nick,
          'e_mail': e_mail,
          'password': password
        }));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      Preferences.userNick = nick;
      return null;
    } else {
      if (decodedResp['error'].toString() == 'Existe nick') {
        return 'El nombre de usuario ya existe';
      }
      return 'El correo electrónico ya existe';
    }
  }

  Future<String?> validateUser(String e_mail, String password) async {
    final url = Uri.http(_baseUrl, '/login');

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
            <String, String>{'nickOcorreo': e_mail, 'password': password}));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      Preferences.userNick = decodedResp['nick'];
      return null;
    } else {
      return 'Correo o contraseña incorrecto(s)';
    }
  }

  Future logOut() async {
    await storage.deleteAll();
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
