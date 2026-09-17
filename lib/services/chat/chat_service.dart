import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/message.dart';

class ChatService {
  
  // obter instancias do firestore e auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // obter user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshots){
      return snapshots.docs.map((doc) {

        // vai individualmente por cada utilizador
        final user = doc.data();

        // retorna o utilizador
        return user;
      }).toList();
    });
  }

  // enviar mensagem
  Future <void> sendMessage(String receiverID, message) async {
    // obter informação do utilizador logado
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // criar nova mensagem
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,

    );
    
    // construir um chat room Id para os dois utilizadores (aleatorio para garantir seja unico)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // ordenar o ids (isto garante que o chat room id seja o mesmo para ambos os utilizadores)
    String chatRoomID = ids.join('_');

    // adicionar nova mensagem a base de dados
    await _firestore
    .collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .add(newMessage.toMap());
  }

  // obter mensagens
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    // construir um chat room ID para os dois utilizadores
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .orderBy("timestamp", descending: false)
      .snapshots();
  }
}