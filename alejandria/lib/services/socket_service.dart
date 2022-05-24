import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {
  
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect() async {
    final storage = new FlutterSecureStorage();

    _socket = IO.io("http://51.255.50.207:5000",{
      'transports': ['websocket'],
      'withCredentials': true,
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': await storage.read(key: 'token') ?? '',
        "my-custom-header": "abcd"
      }
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }


  void disconnect() {
   this._socket.disconnect();
  }

}