import 'dart:io';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mensajes_response.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  final List<ChatMessage> _messages = [];
  // final List<ChatMessage> _messages = [
  //   const ChatMessage(texto: 'Hola Herman', uid: '123'),
  //   const ChatMessage(texto: 'Probando mensajes míos', uid: '123'),
  //   const ChatMessage(texto: 'Probando mensajes de otros', uid: '155'),
  //   const ChatMessage(texto: 'xxxxxxx', uid: '155'),
  // ];
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(chatService.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> chat = await chatService.getChat(usuarioID);
    //print(chat);
    final history = chat.map((m) => ChatMessage(
      texto: m.mensaje, 
      uid: m.de, 
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300))..forward()
          )
    );
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {
    ChatMessage message = ChatMessage(
      texto: payload['mensaje'],
      uid: payload['de'],
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );

    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioPara = chatService.usuarioPara;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(children: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            maxRadius: 14,
            child: Text(
              usuarioPara.name.substring(0, 2),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            usuarioPara.name,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          )
        ]),
        centerTitle: true,
      ),
      body: Container(
          child: Column(
        children: [
          Flexible(
              child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _messages.length,
            itemBuilder: (_, i) => _messages[i],
            reverse: true,
          )),
          const Divider(
            height: 1,
          ),
          Container(color: Colors.white, height: 100, child: _inputChat())
        ],
      )),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: [
        Flexible(
            child: TextField(
          controller: _textController,
          onSubmitted: _handleSubmit,
          onChanged: (String texto) {
            setState(() {
              _estaEscribiendo = true;
            });
          },
          decoration:
              const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
          focusNode: _focusNode,
        )),
        //botón de enviar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Platform.isIOS
              ? CupertinoButton(
                  onPressed: _estaEscribiendo
                      ? () => _handleSubmit(_textController.text)
                      : null,
                  child: const Text('Enviar'),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.send,
                      color: _estaEscribiendo ? Colors.blue : Colors.grey,
                    ),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text)
                        : null,
                  ),
                ),
        )
      ]),
    ));
  }

  _handleSubmit(String texto) {
    //print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
        texto: texto,
        uid: authService.usuario.uid,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 200)));
    _messages.insert(0, newMessage);
    setState(() {
      _estaEscribiendo = false;
    });
    socketService.emit('mensaje-personal', {
      'de': authService.usuario.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    //TODO off del socket
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}
