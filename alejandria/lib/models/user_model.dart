// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';
import 'package:alejandria/models/tematica_model.dart';

class UserModel {
  UserModel({
    required this.nick,
    this.fotoDePerfil,
    this.nombreDeUsuario,
    this.descripcion,
    this.link,
    required this.tematicas,
    required this.nposts,
    required this.nseguidores,
    required this.nsiguiendo,
  });

  String nick;
  String? fotoDePerfil;
  String? nombreDeUsuario;
  String? descripcion;
  String? link;
  List<Tematica> tematicas;
  int nposts;
  int nseguidores;
  int nsiguiendo;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        nick: json["nick"],
        fotoDePerfil: json["foto_de_perfil"],
        nombreDeUsuario: json["nombre_de_usuario"],
        descripcion: json["descripcion"],
        link: json["link"],
        tematicas: List<Tematica>.from(json["tematicas"].map((x) => x)),
        nposts: json["nposts"],
        nseguidores: json["nseguidores"],
        nsiguiendo: json["nsiguiendo"],
      );

  Map<String, dynamic> toMap() => {
        "nick": nick,
        "foto_de_perfil": fotoDePerfil,
        "nombre_de_usuario": nombreDeUsuario,
        "descripcion": descripcion,
        "link": link,
        "tematicas": List<Tematica>.from(tematicas.map((x) => x)),
        "nposts": nposts,
        "nseguidores": nseguidores,
        "nsiguiendo": nsiguiendo,
      };

  UserModel copy() => UserModel(
      nick: this.nick,
      fotoDePerfil: this.fotoDePerfil,
      nombreDeUsuario: this.nombreDeUsuario,
      descripcion: this.descripcion,
      link: this.link,
      tematicas: this.tematicas,
      nposts: this.nposts,
      nseguidores: this.nseguidores,
      nsiguiendo: this.nsiguiendo);
}
