import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [
    ChatMessage(texto: 'Hola Herman', uid: '123'),
    ChatMessage(texto: 'Probando mensajes míos', uid: '123'),
    ChatMessage(texto: 'Probando mensajes de otros', uid: '155'),
    ChatMessage(texto: 'xxxxxxx', uid: '155'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Column(children: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            maxRadius: 14,
            child: Text(
              'Te',
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            'Javier Hernández',
            style: TextStyle(color: Colors.black, fontSize: 12),
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
                  child: const Text('Enviar'),
                  onPressed: _estaEscribiendo
                      ? () => _handleSubmit(_textController.text)
                      : null,
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

    final newMessage = ChatMessage(texto: texto, uid: '123');
    _messages.insert(0, newMessage);
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    //TODO off del socket

    super.dispose();

  }
}
