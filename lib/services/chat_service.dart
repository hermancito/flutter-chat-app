import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/mensajes_response.dart';
import 'auth_service.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    try {
      final String? token = await AuthService.getToken();
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID'),
          headers: {'Content-Type': 'application/json', 'x-token': token!});

      final mensajesResponse = MensajesResponse.fromJson(resp.body);
      return mensajesResponse.mensajes;
    } catch (e) {
      return [];
    }
  }
}
