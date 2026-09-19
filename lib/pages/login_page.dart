import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

  // servicos de autenticação
  final authService = AuthService();

  //metodo para login
  void login(BuildContext context) async{
    
    // try login
    try{
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    }

    // encontrar erros
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  //esqueceu senha
  void openForgotPasswordBox(BuildContext context) async{
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Esqueceu a Senha?"),
        content: MyTextFields(
          hintText: "Digite o email..", 
          obscureText: false, 
          controller: _emailController
        ),
        actions: [
          // botao para cancelar
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Cancelar"),
          ),

          // batao para Recuperar
          TextButton(
            onPressed: () async {
              String message = 
                await authService.forgotPassword(_emailController.text);
              
              if(message == "Email de recuperação da senha enviado! Verifique sua caixa electronica") {
                Navigator.pop(context);
                _emailController.clear();
              }

              ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
            }, 
            child: const Text("Recuperar Conta")
          ),

        ],
      ),
    );
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
            Lottie.asset('assets/lotties/Login.json',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
              repeat: true,
              animate: true,
            ),

            const SizedBox(height: 25),

            // welcome back message
            Text("Bem-Vindo de Volta!",
              style: TextStyle(
                fontSize: 26,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),

            Text("Faça Login para acessar a sua conta",
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
              icon: Icon(Icons.email_outlined),
            ),
            
            const SizedBox(height: 10),

            // password textfield
            MyTextFields(
              hintText: "Senha",
              obscureText:true,
              controller: _pwController,
              icon: Icon(Icons.lock_outline),
            ),

            const SizedBox(height: 8),

            // esqueceu senha
            GestureDetector(
              onTap: () => openForgotPasswordBox(context),
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Esqueceu Senha?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
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