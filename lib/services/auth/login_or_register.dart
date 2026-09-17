import 'package:flutter/material.dart';
import 'package:moz_chat/pages/login_page.dart';
import 'package:moz_chat/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // inicialmente, mostra pagina login
  bool showLoginPage = true;

  // metodo para alternar entre login e register
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}