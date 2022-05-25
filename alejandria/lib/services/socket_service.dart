import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {

  late IO.Socket _socket;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect() async{
    final storage = new FlutterSecureStorage();

    _socket = IO.io("http://51.255.50.207:4000",{
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': await storage.read(key: 'token') ?? '',
      }
    });

    socket.onConnect((_) {
      print('Conectado al socket');
    });

    socket.onDisconnect((_) {
      print('Desconectado del socket');
    });

  }

  void disconnect() {
   this._socket.disconnect();
  }

}