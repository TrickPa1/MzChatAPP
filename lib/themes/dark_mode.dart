import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade700,
    tertiary: Colors.white,
    inversePrimary: Colors.black87,
  ),
  textTheme: GoogleFonts.montserratTextTheme(
    ThemeData.dark().textTheme
  ),
);