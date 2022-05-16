import 'dart:convert';

import 'package:alejandria/models/models.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MyPostsService extends ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';

  //Variables para controlar mis posts
  List<PostListModel> misArticulos = [];
  int offsetArticulos = 0;
  bool finArticulos = false;
  List<PostListModel> misRecs = [];
  int offsetRecs = 0;
  bool finRecs = false;

  //Variables para controlar posts home
  List<PostListModel> postsHome = [];
  int offsetHome = 0;
  bool finHome = false;

  //Variables para controlar posts de otro usuario
  List<PostListModel> otrosArticulos = [];
  int offsetOtrosArticulos = 0;
  bool finOtrosArticulos = false;
  List<PostListModel> otrasRecs = [];
  int offsetOtrasRecs = 0;
  bool finOtrasRecs = false;

  //Variables para controlar posts guardados
  List<PostListModel> misArticulosG = [];
  int offsetArticulosG = 1;
  bool finSavedArticles = false;
  List<PostListModel> misRecsG = [];
  int offsetRecsG = 1;
  bool finSavedRecs = false;

  final storage = new FlutterSecureStorage();

  bool isLoadingArticles = true;

  MyPostsService() {
    this.loadArticles(Preferences.userNick);
    this.loadRecs(Preferences.userNick);
  }

  Future<List<PostListModel>> loadArticles(String nick) async {
    bool soyYo = Preferences.userNick == nick;

    final url = Uri.http(_baseUrl, '/mostrarArticulosPaginados');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'offset': 0.toString(),
        'limit': 6.toString(),
        'nick': nick
      },
    );

    final Map<String, dynamic> articlesMap = json.decode(resp.body);

    soyYo ? misArticulos = [] : otrosArticulos = [];

    if (!articlesMap.containsKey('fin')) {
      articlesMap.forEach((key, value) {
        final tempArticle = PostListModel.fromMap(value);
        tempArticle.id = key;
        if (soyYo)
          this.misArticulos.add(tempArticle);
        else
          this.otrosArticulos.add(tempArticle);
      });
      if (soyYo) {
        finArticulos = false;
        offsetArticulos = 1;
      } else {
        finOtrosArticulos = false;
        offsetOtrosArticulos = 1;
      }
    }

    return this.misArticulos;
  }

  Future<void> loadMoreArticles(String nick) async {
    bool soyYo = nick == Preferences.userNick;
    if (soyYo ? finArticulos : finOtrosArticulos) return;
    final url = Uri.http(_baseUrl, '/mostrarArticulosPaginados');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'offset': soyYo
            ? offsetArticulos.toString()
            : offsetOtrosArticulos.toString(),
        'limit': 6.toString(),
        'nick': nick
      },
    );

    final Map<String, dynamic> articlesMap = json.decode(resp.body);

    if (articlesMap.containsKey('fin')) {
      soyYo ? finArticulos = true : finOtrosArticulos = true;
      return;
    }

    articlesMap.forEach((key, value) {
      final tempArticle = PostListModel.fromMap(value);
      tempArticle.id = key;
      if (soyYo)
        this.misArticulos.add(tempArticle);
      else
        this.otrosArticulos.add(tempArticle);
    });

    soyYo ? offsetArticulos += 1 : offsetOtrosArticulos += 1;
    notifyListeners();
    return;
  }

  Future<void> loadRecs(String nick) async {
    bool soyYo = nick == Preferences.userNick;
    final url = Uri.http(_baseUrl, '/mostrarRecomendacionesPaginadas');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'offset': 0.toString(),
      'limit': 4.toString(),
      'nick': nick
    });

    final Map<String, dynamic> recMap = json.decode(resp.body);

    soyYo ? misRecs = [] : otrasRecs = [];

    if (!recMap.containsKey('fin')) {
      recMap.forEach((key, value) {
        final tempRec = PostListModel.fromMap(value);
        tempRec.id = key;
        if (soyYo)
          this.misRecs.add(tempRec);
        else
          this.otrasRecs.add(tempRec);
      });
      if (soyYo) {
        offsetRecs = 1;
        finRecs = false;
      } else {
        offsetOtrasRecs = 1;
        finOtrasRecs = false;
      }
    }
  }

  Future<void> loadMoreRecs(String nick) async {
    bool soyYo = nick == Preferences.userNick;
    if (soyYo ? finRecs : finOtrasRecs) return;
    final url = Uri.http(_baseUrl, '/mostrarRecomendacionesPaginadas');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'offset': soyYo ? offsetRecs.toString() : offsetOtrasRecs.toString(),
      'limit': 4.toString(),
      'nick': nick
    });

    final Map<String, dynamic> recMap = json.decode(resp.body);
    if (recMap.containsKey('fin')) {
      soyYo ? finRecs = true : finOtrasRecs = true;
      return;
    }

    recMap.forEach((key, value) {
      final tempRec = PostListModel.fromMap(value);
      tempRec.id = key;
      if (soyYo)
        this.misRecs.add(tempRec);
      else
        this.otrasRecs.add(tempRec);
    });
    if (soyYo) {
      finRecs = false;
      offsetRecs += 1;
    } else {
      finOtrasRecs = false;
      offsetOtrasRecs += 1;
    }
    notifyListeners();
  }

  Future<List<PostListModel>> loadHome() async {
    final url = Uri.http(_baseUrl, '/HomePaginado');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'offset': 0.toString(),
        'limit': 5.toString()
      },
    );

    final Map<String, dynamic> postsMap = json.decode(resp.body);
    postsHome = [];

    if (!postsMap.containsKey('fin')) {
      postsMap.forEach((key, value) {
        final tempArticle = PostListModel.fromMap(value);
        tempArticle.id = key;
        this.postsHome.add(tempArticle);
      });

      if (postsHome.length < 5) {
        finHome = true;
      } else
        finHome = false;
      offsetHome = 1;
    }
    return this.postsHome;
  }

  Future<void> loadMoreHome() async {
    final url = Uri.http(_baseUrl, '/HomePaginado');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'offset': offsetHome.toString(),
        'limit': 5.toString()
      },
    );

    final Map<String, dynamic> postsMap = json.decode(resp.body);
    if (postsMap.containsKey('fin')) {
      finHome = true;
      return;
    }

    postsMap.forEach((key, value) {
      final tempArticle = PostListModel.fromMap(value);
      tempArticle.id = key;
      this.postsHome.add(tempArticle);
    });
    offsetHome += 1;
    notifyListeners();
  }

  Future<List<PostListModel>> loadSavedArticles() async {
    misArticulosG = [];

    final url = Uri.http(_baseUrl, '/GuardadosArticulosPaginados');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'offset': 0.toString(),
        'limit': 6.toString()
      },
    );

    final Map<String, dynamic> articlesMap = json.decode(resp.body);

    if (!articlesMap.containsKey('fin')) {
      articlesMap.forEach((key, value) {
        final tempArticle = PostListModel.fromMap(value);
        tempArticle.id = key;
        misArticulosG.add(tempArticle);
      });
      finSavedArticles = false;
      offsetArticulosG = 1;
    }
    return misArticulosG;
  }

  Future<void> loadMoreSavedArticles() async {
    if (finSavedArticles) return;
    final url = Uri.http(_baseUrl, '/GuardadosArticulosPaginados');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'offset': offsetArticulosG.toString(),
        'limit': 6.toString()
      },
    );

    final Map<String, dynamic> articlesMap = json.decode(resp.body);
    if (articlesMap.containsKey('fin')) {
      finSavedArticles = true;
      return;
    }

    articlesMap.forEach((key, value) {
      final tempArticle = PostListModel.fromMap(value);
      tempArticle.id = key;
      misArticulosG.add(tempArticle);
    });
    notifyListeners();
    offsetArticulosG += 1;
    return;
  }

  Future<List<PostListModel>> loadSavedRecs() async {
    misRecsG = [];
    final url = Uri.http(_baseUrl, '/GuardadosRecomendacionesPaginados');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'offset': 0.toString(),
      'limit': 4.toString()
    });

    final Map<String, dynamic> recMap = json.decode(resp.body);

    if (!recMap.containsKey('fin')) {
      recMap.forEach((key, value) {
        final tempRec = PostListModel.fromMap(value);
        tempRec.id = key;
        misRecsG.add(tempRec);
      });
      offsetRecsG = 1;
      finSavedRecs = false;
    }
    return misRecsG;
  }

  Future<void> loadMoreSavedRecs() async {
    if (finSavedRecs) return;
    final url = Uri.http(_baseUrl, '/GuardadosRecomendacionesPaginados');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'offset': offsetRecsG.toString(),
      'limit': 4.toString()
    });
    final Map<String, dynamic> recMap = json.decode(resp.body);
    if (recMap.containsKey('fin')) {
      finSavedRecs = true;
      return;
    }

    recMap.forEach((key, value) {
      final tempRec = PostListModel.fromMap(value);
      tempRec.id = key;
      misRecsG.add(tempRec);
    });
    offsetRecsG += 1;
    notifyListeners();
  }

  void resetSavedPosts() {
    misArticulosG = [];
    misRecsG = [];
  }

  void resetOtherPosts() {
    otrosArticulos = [];
    otrasRecs = [];
  }
}
