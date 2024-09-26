import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { OnLine, OffLine, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  String actualStatus = 'Conectando..';
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {
    final token = await AuthService.getToken();

    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders':{
        'x-token': token
      }
    });
    // _socket = IO.io('https://flutter-socket-io-server-pfx4.onrender.com/', {
    //   'transports': ['websocket'],
    //   'autoConnect': true
    // });
    _socket.onConnect((_) {
      print('connect');
      actualStatus = 'Conectado!!';
      _serverStatus = ServerStatus.OnLine;
      notifyListeners();
      //socket.emit('msg', 'test');
    });

    _socket.on('event', (data) => print(data));

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.OffLine;
      notifyListeners();
    });

    _socket.on('fromServer', (_) => print(_));

    // _socket.on('nuevo-mensaje', (payload) {
    //   print('nuevo-mensaje: $payload');
    //   print('Nombre:' + payload['nombre']);
    //   print('Mensaje:' + payload['mensaje']);
    // });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
