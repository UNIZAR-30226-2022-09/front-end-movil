
import 'dart:convert';

class Mensaje {
  Mensaje({
    required this.nick,
    //required this.created_at,
    //required this.update_at,
    required this.message,
    //required this.room,
  });

  String nick;
  //DateTime created_at;
  //DateTime update_at;
  String message;
  //String room;


  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
    nick: json["nick"],
    //created_at: DateTime.parse(json["created_at"]),
    //update_at: DateTime.parse(json["update_at"]),
    message: json["message"],
    //room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "nick": nick,
    //"created_at": created_at.toIso8601String(),
    //"update_at": update_at.toIso8601String(),
    "message": message,
    //"room": room,
  };
}

MensajesResponse mensajesResponseFromJson(String str) => MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) => json.encode(data.toJson());

class MensajesResponse {
  MensajesResponse({
    required this.ok,
    required this.mensajes,
  });

  bool ok;
  List<Mensaje> mensajes;

  factory MensajesResponse.fromJson(Map<String, dynamic> json) => MensajesResponse(
    ok: json["ok"],
    mensajes: List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
  };
}