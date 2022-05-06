// To parse this JSON data, do
//
//     final SearchResponse = SearchResponseFromMap(jsonString);

import 'dart:convert';

class SearchResponse {
  SearchResponse({
    required this.mySearchResponses,
  });

  List<MySearchResponse> mySearchResponses;

  factory SearchResponse.fromJson(String str) =>
      SearchResponse.fromMap(json.decode(str));

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        mySearchResponses: List<MySearchResponse>.from(
            json["MySearchResponses"].map((x) => MySearchResponse.fromMap(x))),
      );
}

class MySearchResponse {
  MySearchResponse({
    required this.nick,
    required this.fotoDePerfil,
  });

  String nick;
  String fotoDePerfil;

  factory MySearchResponse.fromJson(String str) =>
      MySearchResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MySearchResponse.fromMap(Map<String, dynamic> json) =>
      MySearchResponse(
        nick: json["nick"],
        fotoDePerfil: json["foto_de_perfil"],
      );

  Map<String, dynamic> toMap() => {
        "nick": nick,
        "foto_de_perfil": fotoDePerfil,
      };
}
