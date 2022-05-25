// import 'dart:convert';

// class Notificaciones {
//   Notificaciones({
//     required this.tipo,
//     required this.nickEmisor,
//     required this.fotoDePerfil,
//     this.comentario,
//     this.idPubli,
//   });

//   int tipo;
//   String nickEmisor;
//   String fotoDePerfil;
//   String? comentario;
//   String? idPubli;

//   factory Notificaciones.fromJson(String str) =>
//       Notificaciones.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Notificaciones.fromMap(Map<String, dynamic> json) =>
//       Notificaciones(
//         tipo: json["tipo"],
//         nickEmisor: json["nickEmisor"],
//         fotoDePerfil: json["foto_de_perfil"],
//         comentario: json["comentario"],
//         idPubli: json["idPubli"],
//       );

//   Map<String, dynamic> toMap() => {
//         "tipo": tipo,
//         "nickEmisor": nickEmisor,
//         "foto_de_perfil": fotoDePerfil,
//         "comentario": comentario,
//         "idPubli": idPubli,
//       };
// }

import 'dart:convert';

class Notificaciones {
  Notificaciones({
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

  factory Notificaciones.fromJson(String str) =>
      Notificaciones.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notificaciones.fromMap(Map<String, dynamic> json) => Notificaciones(
        tipo: json["tipo"],
        nickEmisor: json["nickEmisor"],
        fotoDePerfil: json["foto_de_perfil"],
        comentario: json["comentario"],
        idPubli: json["idPubli"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "tipo": tipo,
        "nickEmisor": nickEmisor,
        "foto_de_perfil": fotoDePerfil,
        "comentario": comentario,
        "idPubli": idPubli,
      };
}
