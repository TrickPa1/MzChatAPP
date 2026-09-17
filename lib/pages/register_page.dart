import 'package:flutter/material.dart';
import 'package:moz_chat/services/auth/auth_service.dart';
import 'package:moz_chat/components/my_buttons.dart';
import 'package:moz_chat/components/my_textfields.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  
  // clique para ir para pagina de login
  final void Function()? onTap;

  RegisterPage ({
    super.key,
    required this.onTap,
  });

  // meteodo para registrar
  void register(BuildContext context){
    //obter servicos de autenticação
    final _auth = AuthService();
    
    // se as palavras passes forem iguais 
    if(_pwController.text == _confirmPwController.text){
      try{
        _auth.signUpwithEmailPassword(
          _emailController.text, 
          _pwController.text
        );
      }catch (e) {
        showDialog(
          context: context,
          builder:  (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }

    // se as palavras passes nao forem iguais, mostrar erro
    else{
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Senhas Diferentes!!"),
        )
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.tertiary,
            ),

            const SizedBox(height: 50),

            // welcome back message
            Text("Vamos criar sua conta",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 25),

            // email textfield
            MyTextFields(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            
            const SizedBox(height: 10),

            // password textfield
            MyTextFields(
              hintText: "Senha",
              obscureText:true,
              controller: _pwController,
            ),

            const SizedBox(height: 10),

            // confirmar senha
             MyTextFields(
              hintText: "Confirmar Senha",
              obscureText:true,
              controller: _confirmPwController,
            ),

            const SizedBox(height: 25),

            // login button
            MyButtons(
              text: "Register",
              onTap: () => register(context),
            ),

            const SizedBox(height: 25),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Já tem uma conta?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ), 
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Faça Login Agora",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}