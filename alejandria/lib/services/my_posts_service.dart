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

  //Variables Para Controlar explorados
  List<PostListModel> novedades = [];
  List<PostListModel> populares = [];
  int offsetPopulares = 1;
  bool finPopulares = false;

  List<PostListModel> novedadesR = [];
  List<PostListModel> popularesR = [];
  int offsetPopularesR = 1;
  bool finPopularesR = false;

  late PostListModel postRT;

  final storage = new FlutterSecureStorage();

  bool isLoadingArticles = true;

  MyPostsService() {
    this.loadArticles(Preferences.userNick);
    this.loadRecs(Preferences.userNick);
    this.loadHome();
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

    if (resp.statusCode > 400) return loadArticles(nick);
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
    if (resp.statusCode > 400) return loadMoreArticles(nick);
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

    if (resp.statusCode > 400) return loadRecs(nick);
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

    if (resp.statusCode > 400) return loadMoreRecs(nick);
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
    postsHome = [];
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

    if (resp.statusCode > 400) return loadHome();
    final Map<String, dynamic> postsMap = json.decode(resp.body);

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
    notifyListeners();
    return this.postsHome;
  }

  Future<void> loadMoreHome() async {
    if(finHome){
      return;
    }
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

    if (resp.statusCode > 400) return loadMoreHome();
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

    if (resp.statusCode > 400) return loadSavedArticles();
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

    if (resp.statusCode > 400) return loadMoreSavedArticles();
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

    if (resp.statusCode > 400) return loadSavedRecs();
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

    if (resp.statusCode > 400) return loadMoreSavedRecs();
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

  Future<void> LoadNovedades(String tematica, String texto) async {
    novedades = [];
    if (texto.length == 0) texto = '';
    final url = Uri.http(_baseUrl, '/RecientesArticulos');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'limit': 20.toString(),
        'tematicas': tematica,
        'filtrado': texto
      },
    );

    if (resp.statusCode > 400) return LoadNovedades(tematica, texto);
    final Map<String, dynamic> explorerMap = json.decode(resp.body);
    if (explorerMap.containsKey('fin')) return;
    explorerMap.forEach((key, value) {
      final temp = PostListModel.fromMap(value);
      temp.id = key;
      novedades.add(temp);
    });
    notifyListeners();
  }

  Future<void> LoadPopulares(String tematica, String texto) async {
    populares = [];
    final url = Uri.http(_baseUrl, '/PopularesArticulos');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'limit': 9.toString(),
        'offset': 0.toString(),
        'tematicas': tematica,
        'filtrado': texto
      },
    );

    if (resp.statusCode > 400) return LoadPopulares(tematica, texto);
    final Map<String, dynamic> explorerMap = json.decode(resp.body);
    if (explorerMap.containsKey('fin')) return;
    explorerMap.forEach((key, value) {
      final temp = PostListModel.fromMap(value);
      temp.id = key;
      populares.add(temp);
    });
    finPopulares = false;
    offsetPopulares = 1;
    notifyListeners();
  }

  Future<void> LoadMorePopulares(String tematica, String texto) async {
    if (finPopulares) return;
    final url = Uri.http(_baseUrl, '/PopularesArticulos');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'limit': 9.toString(),
        'offset': offsetPopulares.toString(),
        'tematicas': tematica,
        'filtrado': texto
      },
    );

    if (resp.statusCode > 400) return LoadMorePopulares(tematica, texto);
    final Map<String, dynamic> explorerMap = json.decode(resp.body);
    if (explorerMap.containsKey('fin')) {
      finPopulares = true;
      return;
    }
    explorerMap.forEach((key, value) {
      final temp = PostListModel.fromMap(value);
      temp.id = key;
      populares.add(temp);
    });
    offsetPopulares += 1;
    notifyListeners();
  }

  Future<void> LoadNovedadesR(String tematica, String texto) async {
    novedadesR = [];
    if (texto.length == 0) texto = '';
    final url = Uri.http(_baseUrl, '/RecientesRecomendaciones');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'limit': 20.toString(),
        'tematicas': tematica,
        'filtrado': texto
      },
    );

    if (resp.statusCode > 400) return LoadNovedadesR(tematica, texto);

    final Map<String, dynamic> explorerMap = json.decode(resp.body);
    if (explorerMap.containsKey('fin')) return;
    explorerMap.forEach((key, value) {
      final temp = PostListModel.fromMap(value);
      temp.id = key;
      novedadesR.add(temp);
    });
    notifyListeners();
  }

  Future<void> LoadPopularesR(String tematica, String texto) async {
    popularesR = [];
    final url = Uri.http(_baseUrl, '/PopularesRecomendaciones');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'limit': 4.toString(),
        'offset': 0.toString(),
        'tematicas': tematica,
        'filtrado': texto
      },
    );

    if (resp.statusCode > 400) return LoadPopularesR(tematica, texto);
    final Map<String, dynamic> explorerMap = json.decode(resp.body);
    if (explorerMap.containsKey('fin')) return;
    explorerMap.forEach((key, value) {
      final temp = PostListModel.fromMap(value);
      temp.id = key;
      popularesR.add(temp);
    });
    finPopularesR = false;
    offsetPopularesR = 1;
    notifyListeners();
  }

  Future<void> LoadMorePopularesR(String tematica, String texto) async {
    if (finPopularesR) return;
    final url = Uri.http(_baseUrl, '/PopularesRecomendaciones');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'limit': 4.toString(),
        'offset': offsetPopularesR.toString(),
        'tematicas': tematica,
        'filtrado': texto
      },
    );

    if (resp.statusCode > 400) return LoadMorePopularesR(tematica, texto);
    final Map<String, dynamic> explorerMap = json.decode(resp.body);
    if (explorerMap.containsKey('fin')) {
      finPopularesR = true;
      return;
    }
    explorerMap.forEach((key, value) {
      final temp = PostListModel.fromMap(value);
      temp.id = key;
      popularesR.add(temp);
    });
    offsetPopularesR += 1;
    notifyListeners();
  }

  Future<void> getInfoPost(String id) async {
    final url = Uri.http(_baseUrl, '/infoPost');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'id': id
      },
    );

    if (resp.statusCode > 400) return getInfoPost(id);
    final Map<String, dynamic> postMap = json.decode(resp.body);
    postMap.forEach((key, value) {
      postRT = PostListModel.fromMap(value);
    });
    postRT.id = id;
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
