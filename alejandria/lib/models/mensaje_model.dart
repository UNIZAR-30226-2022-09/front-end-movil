
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

