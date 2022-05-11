import 'dart:convert';

class ComentraioModel {
  ComentraioModel({
    required this.nick,
    required this.fotoDePerfil,
    required this.comentario,
  });

  String nick;
  String fotoDePerfil;
  String comentario;

  factory ComentraioModel.fromJson(String str) =>
      ComentraioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ComentraioModel.fromMap(Map<String, dynamic> json) => ComentraioModel(
        nick: json["nick"],
        fotoDePerfil: json["foto_de_perfil"],
        comentario: json["comentario"],
      );

  Map<String, dynamic> toMap() => {
        "nick": nick,
        "foto_de_perfil": fotoDePerfil,
        "comentario": comentario,
      };
}
