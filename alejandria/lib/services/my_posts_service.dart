import 'dart:convert';

import 'package:alejandria/models/models.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MyPostsService extends ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';

  List<PostListModel> misArticulos = [];
  List<PostListModel> misRecs = [];
  List<PostListModel> postsHome = [];

  final storage = new FlutterSecureStorage();

  bool isLoadingArticles = true;
  bool isLoadingRec = true;

  MyPostsService() {
    this.loadArticles(Preferences.userNick);
    this.loadRecs(Preferences.userNick);
  }

  Future<List<PostListModel>> loadArticles(String nick) async {
    this.isLoadingArticles = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/mostrarArticulos');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'nick': nick
      },
    );

    final Map<String, dynamic> articlesMap = json.decode(resp.body);

    misArticulos = [];

    articlesMap.forEach((key, value) {
      final tempArticle = PostListModel.fromMap(value);
      tempArticle.id = key;
      this.misArticulos.add(tempArticle);
    });
    this.isLoadingArticles = false;
    notifyListeners();

    return this.misArticulos;
  }

  Future<List<PostListModel>> loadRecs(String nick) async {
    this.isLoadingRec = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/mostrarRecomendaciones');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'nick': nick
    });

    final Map<String, dynamic> recMap = json.decode(resp.body);

    misRecs = [];

    recMap.forEach((key, value) {
      final tempRec = PostListModel.fromMap(value);
      tempRec.id = key;
      this.misRecs.add(tempRec);
    });
    this.isLoadingRec = false;
    notifyListeners();

    return this.misRecs;
  }

  Future<List<PostListModel>> loadHome() async {
    final url = Uri.http(_baseUrl, '/Home');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
      },
    );

    final Map<String, dynamic> postsMap = json.decode(resp.body);
    postsHome = [];
    postsMap.forEach((key, value) {
      final tempArticle = PostListModel.fromMap(value);
      tempArticle.id = key;
      this.postsHome.add(tempArticle);
    });

    return this.postsHome;
  }

  Future<List<PostListModel>> loadOtherArticles(String nick) async {
    List<PostListModel> otrosArticulos = [];
    print('me han llamado');
    final url = Uri.http(_baseUrl, '/mostrarArticulos');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'nick': nick
      },
    );

    final Map<String, dynamic> articlesMap = json.decode(resp.body);

    articlesMap.forEach((key, value) {
      final tempArticle = PostListModel.fromMap(value);
      tempArticle.id = key;
      otrosArticulos.add(tempArticle);
    });

    return otrosArticulos;
  }

  Future<List<PostListModel>> loadOtherRecs(String nick) async {
    List<PostListModel> otherRecs = [];
    final url = Uri.http(_baseUrl, '/mostrarRecomendaciones');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'nick': nick
    });

    final Map<String, dynamic> recMap = json.decode(resp.body);

    recMap.forEach((key, value) {
      final tempRec = PostListModel.fromMap(value);
      tempRec.id = key;
      otherRecs.add(tempRec);
    });

    return otherRecs;
  }

  Future<List<PostListModel>> loadSavedArticles() async {
    List<PostListModel> misArticulosGuardados = [];

    final url = Uri.http(_baseUrl, '/GuardadosArticulos');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
      },
    );

    final Map<String, dynamic> articlesMap = json.decode(resp.body);

    articlesMap.forEach((key, value) {
      final tempArticle = PostListModel.fromMap(value);
      tempArticle.id = key;
      misArticulosGuardados.add(tempArticle);
    });

    return misArticulosGuardados;
  }

  Future<List<PostListModel>> loadSavedRecs() async {
    List<PostListModel> misRecsGuardadas = [];
    final url = Uri.http(_baseUrl, '/GuardadosRecomendaciones');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
    });

    final Map<String, dynamic> recMap = json.decode(resp.body);

    recMap.forEach((key, value) {
      final tempRec = PostListModel.fromMap(value);
      tempRec.id = key;
      misRecsGuardadas.add(tempRec);
    });

    return misRecsGuardadas;
  }
}
