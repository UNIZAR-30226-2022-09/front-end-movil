import 'package:alejandria/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

export 'package:alejandria/models/notificaciones_model.dart';

class NotificacionesService extends ChangeNotifier {
  final String _baseUrl = '51.255.50.207:5000';

  final storage = new FlutterSecureStorage();

  List<Notificaciones> misNotificaciones = [];
  int offsetNotificaciones = 1;
  bool finNotificaciones = false;

  // Future<List<NotificacionesModel>> loadNotificaciones() async {
  //   misNotificaciones = [];
  //   final url = Uri.http(_baseUrl, '/notificaciones');
  //   final resp = await http.get(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'token': await storage.read(key: 'token') ?? '',
  //       'offset': 0.toString(),
  //       'limit': 10.toString()
  //     },
  //   );

  //   if (resp.statusCode > 400) return loadNotificaciones();
  //   final Map<String, dynamic> notificacionesMap = json.decode(resp.body);
  //   print('aqui');

  //   if (!notificacionesMap.containsKey('fin')) {
  //     notificacionesMap.forEach((key, value) {
  //       final notificacionTemp = NotificacionesModel.fromMap(value);
  //       misNotificaciones.add(notificacionTemp);
  //     });
  //     finNotificaciones = false;
  //     offsetNotificaciones = 1;
  //   }
  //   print('ahi');

  //   print(misNotificaciones.length);

  //   return misNotificaciones;
  // }

  Future<void> loadNotificaciones() async {
    misNotificaciones = [];
    final url = Uri.http(_baseUrl, '/notificaciones');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'limit': 10.toString(),
        'offset': 0.toString()
      },
    );
    if (resp.statusCode > 400) return loadNotificaciones();
    final Map<String, dynamic> notMap = json.decode(resp.body);
    print(json.decode(resp.body));
    if (notMap.containsKey('fin')) {
      notifyListeners();
      return;
    }

    notMap.forEach((key, value) {
      misNotificaciones.add(Notificaciones.fromMap(value));
    });
    finNotificaciones = false;
    offsetNotificaciones = 1;
    notifyListeners();
  }

  Future<void> loadMoreNotificaciones() async {
    if (finNotificaciones) return;
    final url = Uri.http(_baseUrl, '/notificaciones');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await storage.read(key: 'token') ?? '',
        'offset': offsetNotificaciones.toString(),
        'limit': 10.toString()
      },
    );

    if (resp.statusCode > 400) return loadMoreNotificaciones();
    final Map<String, dynamic> articlesMap = json.decode(resp.body);
    if (articlesMap.containsKey('fin')) {
      finNotificaciones = true;
      return;
    }

    articlesMap.forEach((key, value) {
      misNotificaciones.add(Notificaciones.fromMap(value));
    });
    notifyListeners();
    offsetNotificaciones += 1;
    return;
  }
}
