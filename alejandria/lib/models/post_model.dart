// To parse this JSON data, do
//
//     final postModel = postModelFromMap(jsonString);

import 'dart:convert';

class PostModel {
  PostModel({
    required this.tipo,
    this.descripcion,
    this.titulo,
    this.autor,
    this.link,
    required this.tematicas,
    this.pdf,
    this.nlikes,
    this.ncomentarios,
    this.nguardados,
    this.usuario,
    this.fotoDePerfil,
  });

  String tipo;
  String? descripcion;
  String? titulo;
  String? autor;
  String? link;
  List<String> tematicas;
  String? pdf;
  String? nlikes;
  String? ncomentarios;
  String? nguardados;
  String? usuario;
  String? fotoDePerfil;

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        tipo: json["tipo"],
        descripcion: json["descripcion"],
        titulo: json["titulo"],
        autor: json["autor"],
        link: json["link"],
        tematicas: List<String>.from(json["tematicas"].map((x) => x)),
        pdf: json["pdf"],
        nlikes: json["nlikes"],
        ncomentarios: json["ncomentarios"],
        nguardados: json["nguardados"],
        usuario: json["usuario"],
        fotoDePerfil: json["foto_de_perfil"],
      );

  Map<String, dynamic> toMap() => {
        "tipo": tipo,
        "descripcion": descripcion,
        "titulo": titulo,
        "autor": autor,
        "link": link,
        "tematicas": List<dynamic>.from(tematicas.map((x) => x)),
        "pdf": pdf,
        "nlikes": nlikes,
        "ncomentarios": ncomentarios,
        "nguardados": nguardados,
        "usuario": usuario,
        "foto_de_perfil": fotoDePerfil,
      };
}
