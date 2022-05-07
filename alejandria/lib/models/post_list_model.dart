// To parse this JSON data, do
//
//     final postListModel = postListModelFromMap(jsonString);

import 'dart:convert';

class PostListModel {
  PostListModel({
    this.id,
    required this.tipo,
    this.pdf,
    this.portada,
    this.descripcion,
    required this.usuario,
    required this.fotoDePerfil,
    required this.nlikes,
    required this.likemio,
    required this.ncomentarios,
    required this.nguardados,
    required this.guardadomio,
    this.titulo,
    this.autor,
    this.link,
  });

  String? id;
  int tipo;
  String? pdf;
  String? portada;
  String? descripcion;
  String usuario;
  String fotoDePerfil;
  int nlikes;
  bool likemio;
  int ncomentarios;
  int nguardados;
  bool guardadomio;
  String? titulo;
  String? autor;
  String? link;

  factory PostListModel.fromJson(String str) =>
      PostListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostListModel.fromMap(Map<String, dynamic> json) => PostListModel(
        tipo: json["tipo"],
        pdf: json["pdf"] == null ? null : json["pdf"],
        portada: json["portada"] == null ? null : json["portada"],
        descripcion: json["descripcion"],
        usuario: json["usuario"],
        fotoDePerfil: json["foto_de_perfil"],
        nlikes: json["nlikes"],
        likemio: json["likemio"],
        ncomentarios: json["ncomentarios"],
        nguardados: json["nguardados"],
        guardadomio: json["guardadomio"],
        titulo: json["titulo"] == null ? null : json["titulo"],
        autor: json["autor"] == null ? null : json["autor"],
        link: json["link"] == null ? null : json["link"],
      );

  Map<String, dynamic> toMap() => {
        "tipo": tipo,
        "pdf": pdf == null ? null : pdf,
        "portada": portada == null ? null : portada,
        "descripcion": descripcion,
        "usuario": usuario,
        "foto_de_perfil": fotoDePerfil,
        "nlikes": nlikes,
        "likemio": likemio,
        "ncomentarios": ncomentarios,
        "nguardados": nguardados,
        "guardadomio": guardadomio,
        "titulo": titulo == null ? null : titulo,
        "autor": autor == null ? null : autor,
        "link": link == null ? null : link,
      };
}
