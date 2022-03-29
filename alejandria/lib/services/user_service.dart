import 'dart:convert';
import 'dart:io';

import 'package:alejandria/models/models.dart';
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
    this.loadData();
  }

  Future<UserModel> loadData() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/editarPerfil');
    final resp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': await storage.read(key: 'token') ?? ''
    });

    user = UserModel.fromMap(json.decode(resp.body));

    this.isLoading = false;
    notifyListeners();

    return user;
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

    user = userEdit;
    this.isSaving = false;
    notifyListeners();
  }

  void updateSelectedProfileImage(String path) {
    this.userEdit.fotoDePerfil = path;
    this.profilePicture = File.fromUri(Uri(path: path));

    notifyListeners();
  }
}
