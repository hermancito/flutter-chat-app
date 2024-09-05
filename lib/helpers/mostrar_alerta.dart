import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if(Platform.isAndroid){
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                textColor: Colors.blue,
                elevation: 5,
                child: const Text('OK'),
              )
            ],
          )
        );
  }else{
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                isDefaultAction: true,
                child: const Text('OK'),
              )
            ],
          )
        );
  }
  
}
