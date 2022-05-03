import 'dart:convert';
import 'dart:io';

import 'package:alejandria/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MyPostsService extends ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';
  final List<PostListModel> misArticulos = [];
  final List<PostListModel> misRecs = [];

  final storage = new FlutterSecureStorage();

  bool isLoadingArticles = true;
  bool isLoadingRec = true;

  MyPostsService() {
    //this.loadArticles();
    //this.loadRecs();
  }

  //TOODO: <List<PostListModel>>
  Future<List<PostListModel>> loadArticles() async {
    this.isLoadingArticles = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/misArticulos');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? ''
      },
    );

    final Map<String, dynamic> articlesMap = json.decode(resp.body);
    print(articlesMap);

    articlesMap.forEach((key, value) {
      final tempArticle = PostListModel.fromMap(value);
      tempArticle.id = key;
      this.misArticulos.add(tempArticle);
    });
    this.isLoadingArticles = false;
    notifyListeners();

    return this.misArticulos;
  }

  Future<List<PostListModel>> loadRecs() async {
    this.isLoadingRec = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/misRecomendaciones');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? ''
      },
    );

    final Map<String, dynamic> recMap = json.decode(resp.body);
    print(recMap);

    recMap.forEach((key, value) {
      final tempRec = PostListModel.fromMap(value);
      tempRec.id = key;
      this.misRecs.add(tempRec);
    });
    this.isLoadingRec = false;
    notifyListeners();

    return this.misRecs;
  }
}
