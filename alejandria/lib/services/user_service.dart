import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alejandria/models/models.dart';
import 'package:alejandria/models/search_model.dart';
import 'package:alejandria/search/debouncer.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';
  late UserModel user;
  late UserModel userEdit;

  final storage = new FlutterSecureStorage();

  File? profilePicture;

  bool isLoading = true;
  bool isSaving = false;

  UserService() {
    this.loadData(Preferences.userNick);
  }

  Future<UserModel> loadData(String nick) async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, '/mostrarPerfil');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'nick': nick
    });

    user = UserModel.fromMap(json.decode(resp.body));

    this.isLoading = false;
    notifyListeners();

    return user;
  }

  Future<UserModel> loadOtherUser(String nick) async {
    UserModel otherUser;

    final url = Uri.http(_baseUrl, '/mostrarPerfil');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'nick': nick
    });

    otherUser = UserModel.fromMap(json.decode(resp.body));

    return otherUser;
  }

  Future editProfile() async {
    this.isSaving = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, '/editarPerfil');
    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await storage.read(key: 'token') ?? ''
        },
        body: userEdit.toJson());

    if (this.userEdit.cambia_foto == 1) {
      final url2 = Uri.parse('http://$_baseUrl/actualizarImagen');
      final imageUploadRequest = http.MultipartRequest('POST', url2);
      final file =
          await http.MultipartFile.fromPath('nueva_foto', profilePicture!.path);

      imageUploadRequest.files.add(file);
      imageUploadRequest.headers['token'] =
          await storage.read(key: 'token') ?? '';

      await imageUploadRequest.send();
      loadData(Preferences.userNick);
    }

    this.userEdit.cambia_foto = 0;
    user = userEdit;
    //user.tematicas = [...userEdit.tematicas];
    //if (this.userEdit.cambia_foto == 1) {

    //}
    this.isSaving = false;
    notifyListeners();
  }

  void updateSelectedProfileImage(String path) async {
    this.userEdit.fotoDePerfil = path;
    this.profilePicture = File.fromUri(Uri(path: path));
    this.userEdit.cambia_foto = 1;
    notifyListeners();
  }

  //Busqueda de usuarios

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<SearchModel>> _suggestionsSC =
      new StreamController.broadcast();
  Stream<List<SearchModel>> get suggestionsStream => this._suggestionsSC.stream;

  Future<List<SearchModel>> searchUsers(String user) async {
    final url = Uri.http(_baseUrl, '/buscarUsuarios');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? '',
      'nick': user
    });

    List<SearchModel> mySearch = [];

    final Map<String, dynamic> searchMap = json.decode(resp.body);
    searchMap.forEach((key, value) {
      final tempSearch = SearchModel.fromMap(value);
      tempSearch.nick = key;
      mySearch.add(tempSearch);
    });

    return mySearch;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.searchUsers(value);
      this._suggestionsSC.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
