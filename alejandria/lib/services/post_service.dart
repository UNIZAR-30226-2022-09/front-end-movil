import 'dart:io';

import 'package:alejandria/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PostService extends ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';
  late PostModel newPost;

  final storage = new FlutterSecureStorage();

  File? pdfArticle;

  bool isLoading = true;
  bool isSaving = false;

  bool check1 = false;
  bool check2 = false;

  Future uploadPost() async {
    print(newPost.toJson());
    //this.isSaving = true;
    // notifyListeners();

    // final url = Uri.http(_baseUrl, '/subirPost');
    // final resp = await http.post(url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       'token': await storage.read(key: 'token') ?? ''
    //     },
    //     body: newPost.toJson());

    // if (this.newPost.tipo == "1") {
    //   final url2 = Uri.parse('http://$_baseUrl/subirPdf');
    //   final imageUploadRequest = http.MultipartRequest('POST', url2);
    //   final file =
    //       await http.MultipartFile.fromPath('nuevo_pdf', pdfArticle!.path);

    //   imageUploadRequest.files.add(file);
    //   imageUploadRequest.headers['token'] =
    //       await storage.read(key: 'token') ?? '';

    //   await imageUploadRequest.send();

    //   pdfArticle = null;
    //   check1 = false;
    //   check2 = false;
    // }

    // this.isSaving = false;
    // notifyListeners();
  }

  void resetData(int tipo) {
    newPost = PostModel(tipo: tipo.toString(), tematicas: []);
    pdfArticle = null;
    check1 = false;
    check2 = false;
  }

  void notify() {
    notifyListeners();
  }
}
