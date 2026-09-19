import 'package:flutter/material.dart';
import 'package:moz_chat/pages/my_drawer.dart';
import '../services/chat/chat_service.dart';
import '../services/auth/auth_service.dart';
import '../components/user_tile.dart';
import '../pages/chat_page.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});

  // servicos de chat e auth
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // construir lista de utilizadores excepto o utilizador logado
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // erros
        if (snapshot.hasError) {
          return const Text("Erro");
        }

        // carregando..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregando..");
        }

        // retorna lista de utilizadores
        return ListView(
          children: snapshot.data!
          .map<Widget>((userData) => _buildUserListItem(userData, context))
          .toList(),
        );
      },
    );
  }

  // construir lista individual para utilizadores
  Widget _buildUserListItem(
    Map<String, dynamic> userData, BuildContext context) {
    // mostra todos os utilizadores exceto o utilizador logado
      if (userData["email"] != _authService.getCurrentUser()!.email){
        return UserTile(
          text: userData["name"],
          onTap: () {
            // clique no utilizador para pagina de chat
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData["email"],
                  receiverID: userData["uid"],
                  receiverName: userData["name"],
                ),
              ));
          }
        );
      } else {
        return Container(); // retorna um container vazio se for o utilizador logado
      }
  }

}