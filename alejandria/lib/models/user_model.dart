// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

class UserModel {
  UserModel(
      {required this.nick,
      this.fotoDePerfil,
      this.nombreDeUsuario,
      this.descripcion,
      this.link,
      required this.tematicas,
      required this.nposts,
      required this.nseguidores,
      required this.nsiguiendo,
      this.cambia_foto = 0});

  String nick;
  String? fotoDePerfil;
  String? nombreDeUsuario;
  String? descripcion;
  String? link;
  List<String> tematicas;
  int nposts;
  int nseguidores;
  int nsiguiendo;
  int? cambia_foto;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      nick: json["nick"],
      fotoDePerfil: json["foto_de_perfil"],
      nombreDeUsuario: json["nombre_de_usuario"],
      descripcion: json["descripcion"],
      link: json["link"],
      tematicas: List<String>.from(json["tematicas"].map((x) => x)),
      nposts: json["nposts"],
      nseguidores: json["nseguidores"],
      nsiguiendo: json["nsiguiendo"],
      cambia_foto: json["cambia_foto"]);

  Map<String, dynamic> toMap() => {
        "nick": nick,
        "foto_de_perfil": fotoDePerfil,
        "nombre_de_usuario": nombreDeUsuario,
        "descripcion": descripcion,
        "link": link,
        "tematicas": List<String>.from(tematicas.map((x) => x)),
        "nposts": nposts,
        "nseguidores": nseguidores,
        "nsiguiendo": nsiguiendo,
        "cambia_foto": cambia_foto,
      };

  UserModel copy() => UserModel(
      nick: this.nick,
      fotoDePerfil: this.fotoDePerfil,
      nombreDeUsuario: this.nombreDeUsuario,
      descripcion: this.descripcion,
      link: this.link,
      tematicas: [...this.tematicas],
      nposts: this.nposts,
      nseguidores: this.nseguidores,
      nsiguiendo: this.nsiguiendo,
      cambia_foto: this.cambia_foto);
}
