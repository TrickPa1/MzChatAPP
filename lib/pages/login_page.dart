import 'package:flutter/material.dart';
import 'package:moz_chat/services/auth/auth_service.dart';
import 'package:moz_chat/components/my_buttons.dart';
import 'package:moz_chat/components/my_textfields.dart';

class LoginPage extends StatelessWidget {
  //email e pw controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // clique para ir para pagina de registro
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  //metodo para login
  void login(BuildContext context) async{
    // servicos de autenticação
    final authService = AuthService();

    // try login
    try{
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    }

    // encontrar erros
    catch (e) {
      showDialog(context: context, 
      builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ),
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
            Text("Bem-Vindo de Volta!",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.tertiary,
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

            const SizedBox(height: 25),

            // login button
            MyButtons(
              text: "Login",
              onTap: () => login(context),
            ),

            const SizedBox(height: 25),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Não tem uma conta?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ), 
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Registre-se agora",
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