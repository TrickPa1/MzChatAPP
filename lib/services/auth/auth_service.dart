import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {

  // instancias do auth e firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // obter dados do utilizador logado
  User? getCurrentUser(){
    return _auth.currentUser;
  }
  
  // Entrar
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try{
      //Entrar utilizador
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );
      
      //salvar informacao do utilizador caso nao exista
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
      );

      return userCredential;
    }on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  //registar
  Future<UserCredential> signUpwithEmailPassword(String email, password, name) async{
    try{
      // criar utilizador
      UserCredential userCredential = 
          await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );

      //salvar informacao do utilizador
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
          'name' : name,
        }
      );

      return userCredential;

    }on FirebaseAuthException catch (e){
     throw Exception(e.code);
    }
  }

  //Sair
  Future<void> signOut() async{
    return await _auth.signOut();
  }

  //esqueceu senha
  Future<String> forgotPassword(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return "Email de recuperação da senha enviado! Verifique sua caixa electronica";
    }catch(e) {
      return "Aconteceu um erro: $e";
    }
  }
  
 //Erros
 
}
