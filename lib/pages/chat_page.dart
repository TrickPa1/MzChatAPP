import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moz_chat/components/chat_bubble.dart';
import 'package:moz_chat/components/my_textfields.dart';
import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  final String receiverName;
  
  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
    required this.receiverName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // servicos de chat e auth
  final ChatService _chatService = ChatService();
  final AuthService _auth = AuthService();

  //para focar nos textfields
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // adiciona listener para focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // causar delay para o teclado tenha tempo de aparecer
        
        // tamanho do espaco restante sera calculado
        
        // scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    // espera um pouco para o listener ser construido, depois scroll para o fundo
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }  

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, 
      duration: const Duration(seconds: 1), 
      curve: Curves.fastOutSlowIn,
    );
  }

  // enviar mensagem
  void sendMessage() async {
    // se tiver algo dentro do textfield
    if (_messageController.text.isNotEmpty){
      // enviar a mensagem
      await _chatService.sendMessage(widget.receiverID, _messageController.text);

      // limpar o text controller
      _messageController.clear();
    }
    
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.receiverName),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          // mostrar todas as mensagens
          Expanded(
            child: _buildMessageList(),
          ),

          //input do utilizador
          _buildUserInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderID = _auth.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        //erros
        if(snapshot.hasError){
          return const Text("Erro");
        }

        // carregando..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregando..");
        }

        // retorna list view
        return ListView(
          controller: _scrollController,
          children: 
            snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //construir o message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // utilizador logado
    bool isCurrentUser = data['senderID'] == _auth.getCurrentUser()!.uid;

    // alinhar a mensagem para direita se for o remetente for o utilizador logado, senao esquerda
    var alignment = 
      isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"], 
            isCurrentUser: isCurrentUser
          ),
        ],
      ),
    );
  }

  // construir massage input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // o textfield deve levar mais do espaço
          Expanded(
            child: MyTextFields(
              controller: _messageController,
              hintText: "Digite uma Mensagem",
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),
          
          // botão de enviar
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF4A7FA7),
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage, 
              icon: const Icon(Icons.arrow_upward, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}