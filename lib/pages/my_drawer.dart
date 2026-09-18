import 'package:flutter/material.dart';
import 'package:moz_chat/services/auth/auth_service.dart';
import 'package:moz_chat/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer ({super.key});
  
  void logout(){
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            //logo
            DrawerHeader(
              child: Center(
                child: Image.asset('assets/icon/icon.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
              ),
            ),

            //lista para casa
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text("C A S A"),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // lista para definicao
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text("D E F I N I Ç Õ E S"),
                leading: const Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);

                  //navegar para pagina de definições
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
              ),
            ),
          ]),

          //lista para logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text("S A I R"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),

        ],
      ),
    );
  }
}