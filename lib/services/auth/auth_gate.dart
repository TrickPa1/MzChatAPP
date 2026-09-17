import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moz_chat/services/auth/login_or_register.dart';
import 'package:moz_chat/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){

          // utilizador entrou
          if (snapshot.hasData) {
            return HomePage();
          }

          // utilizador nao entrou
          else{
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}