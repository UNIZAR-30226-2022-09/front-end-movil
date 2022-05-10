// To parse this JSON data, do
//
//     final SearchResponse = SearchResponseFromMap(jsonString);

import 'dart:convert';

class SearchModel {
  SearchModel({required this.fotoDePerfil, this.nick});

  String fotoDePerfil;
  String? nick;

  factory SearchModel.fromJson(String str) =>
      SearchModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchModel.fromMap(Map<String, dynamic> json) => SearchModel(
        fotoDePerfil: json["foto_de_perfil"],
      );

  Map<String, dynamic> toMap() => {
        "foto_de_perfil": fotoDePerfil,
      };
}
