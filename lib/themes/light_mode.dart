import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.black87,
    inversePrimary: Color(0xFFEEF0FF),
  ),
  textTheme: GoogleFonts.montserratTextTheme(),
);