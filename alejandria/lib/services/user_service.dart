import 'dart:convert';
import 'dart:io';

import 'package:alejandria/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';
  late UserModel user;

  final storage = new FlutterSecureStorage();

  File? ProfilePicture;

  bool isLoading = true;
  bool isSaving = false;

  UserService() {
    this.loadData();
  }

  Future<UserModel> loadData() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/user');
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

    final url = Uri.http(_baseUrl, '/editProfile');
    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await storage.read(key: 'token') ?? ''
        },
        body: user.toJson());

    this.isSaving = false;
    notifyListeners();
  }

  void updateSelectedProductImage(String path) {
    this.user.fotoDePerfil = path;
    this.ProfilePicture = File.fromUri(Uri(path: path));

    notifyListeners();
  }
}
