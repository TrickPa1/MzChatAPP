import 'package:flutter/material.dart';
import 'package:moz_chat/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  
  ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });


  @override
  Widget build(BuildContext context) {
    //light vs dark mode para as bolhas
    bool isDarkMode = 
    Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser 
          ? (isDarkMode ? Color(0xFF4A7FA7) : Color(0xFF1A3D63)) 
          : (isDarkMode ? Color(0xFFB3CFE5) : Color(0xFFF6FAFD)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser 
            ? Colors.white
            : Colors.black
        ),
      ),
    );
  }
}