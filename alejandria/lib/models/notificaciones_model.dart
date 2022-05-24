// To parse this JSON data, do
//
//     final notificacionesModel = notificacionesModelFromMap(jsonString);

import 'dart:convert';

class NotificacionesModel {
  NotificacionesModel({
    required this.tipo,
    required this.nickEmisor,
    required this.fotoDePerfil,
    this.comentario,
    this.idPubli,
  });

  int tipo;
  String nickEmisor;
  String fotoDePerfil;
  String? comentario;
  String? idPubli;

  factory NotificacionesModel.fromJson(String str) => NotificacionesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificacionesModel.fromMap(Map<String, dynamic> json) => NotificacionesModel(
    tipo: json["tipo"],
    nickEmisor: json["nickEmisor"],
    fotoDePerfil: json["foto_de_perfil"],
    comentario: json["comentario"],
    idPubli: json["idPubli"],
  );

  Map<String, dynamic> toMap() => {
    "tipo": tipo,
    "nickEmisor": nickEmisor,
    "foto_de_perfil": fotoDePerfil,
    "comentario": comentario,
    "idPubli": idPubli,
  };
}