import 'dart:convert';
import 'dart:io';

import 'package:alejandria/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_render/pdf_render.dart' as render;
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:provider/provider.dart';
//import 'package:syncfusion_flutter_pdf/pdf.dart';

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
    this.isSaving = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, '/subirPost');
    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await storage.read(key: 'token') ?? ''
        },
        body: newPost.toJson());

    print(newPost.toJson());

    if (this.newPost.tipo == "1") {
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      int id = decodedResp['id'];
      Uri url2 = Uri.parse('http://$_baseUrl/subirPdf');
      final pdfUploadRequest = http.MultipartRequest('POST', url2);
      final file = await http.MultipartFile.fromPath('pdf', pdfArticle!.path);

      pdfUploadRequest.files.add(file);
      pdfUploadRequest.headers['token'] =
          await storage.read(key: 'token') ?? '';
      pdfUploadRequest.headers['id'] = id.toString();

      await pdfUploadRequest.send();

      pdfArticle = null;
      check1 = false;
      check2 = false;
    } else {}

    this.isSaving = false;
    notifyListeners();
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
