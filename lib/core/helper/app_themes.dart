import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  primaryColor: const Color(0xFF1c8fec),
  scaffoldBackgroundColor: const Color(0xFF0d1117),
  cardColor: const Color(0xFF21262d),
  brightness: Brightness.dark,
  canvasColor: const Color.fromARGB(255, 30, 33, 58),
  textTheme: TextTheme(
    bodySmall: GoogleFonts.fredoka(),
  ),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFFcccccc),
  brightness: Brightness.light,
);
