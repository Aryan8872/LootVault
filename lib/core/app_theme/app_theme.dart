import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getApplicationTheme(){
  return 
      ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(240, 247, 255, 1),
        fontFamily: 'Montserrat Regular',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          
        ),
        textTheme: TextTheme(
          
        )
      
      
      );
}