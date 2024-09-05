import 'package:chat/pages/pages.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': ( _ ) => const UsuariosPage(),
  'chat': ( _ ) => const ChatPage(),
  'register': ( _ ) => const RegisterPage(),
  'login': ( _ ) => const LoginPage(),
  'loading': ( _ ) => const LoadingPage(),
};
