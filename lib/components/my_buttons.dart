import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart';

class MyButtons extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyButtons({
    super.key,
    required this.text,
    required this.onTap,
    });
  
  @override
  Widget build(BuildContext context){
    
    bool isDarkMode = 
    Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xFF4A7FA7) : Color(0xFF1A3D63),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
} 