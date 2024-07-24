import 'package:chat/pages/pages.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': ( _ ) => UsuariosPage(),
  'chat': ( _ ) => ChatPage(),
  'register': ( _ ) => RegisterPage(),
  'login': ( _ ) => LoginPage(),
  'loading': ( _ ) => LoadingPage(),
};
