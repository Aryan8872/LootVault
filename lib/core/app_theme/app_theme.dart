import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(240, 247, 255, 1),
    fontFamily: 'Nunito Regular',
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(0, 107, 255, 1),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust this to match `_cornerRadius`
        ),
        minimumSize: const Size(double.infinity, 50),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    textTheme: const TextTheme(
        displayMedium: TextStyle(
            fontFamily: 'Nunito Bold',
            fontSize: 20,
            fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 14),
        titleMedium: TextStyle(fontSize: 17.8, fontFamily: 'Nunito SemiBold'),
         
        // titleMedium: ,
        ),
  );
}
