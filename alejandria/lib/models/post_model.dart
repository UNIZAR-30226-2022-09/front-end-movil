// To parse this JSON data, do
//
//     final postModel = postModelFromMap(jsonString);

import 'dart:convert';

class PostModel {
  PostModel(
      {required this.tipo,
      this.id,
      this.descripcion,
      this.titulo,
      this.autor,
      this.link,
      required this.tematicas});

  String tipo;
  String? id;
  String? descripcion;
  String? titulo;
  String? autor;
  String? link;
  List<String> tematicas;

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
      tipo: json["tipo"],
      id: json["id"],
      descripcion: json["descripcion"],
      titulo: json["titulo"],
      autor: json["autor"],
      link: json["link"],
      tematicas: List<String>.from(json["tematicas"].map((x) => x)));

  Map<String, dynamic> toMap() => {
        "tipo": tipo,
        "id": id,
        "descripcion": descripcion,
        "titulo": titulo,
        "autor": autor,
        "link": link,
        "tematicas": List<dynamic>.from(tematicas.map((x) => x))
      };
}
