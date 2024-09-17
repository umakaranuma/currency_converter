import 'package:currency_converter_mobil_app/core/theme_data/colour_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var textTheme = TextTheme(
  headlineLarge: GoogleFonts.montserrat(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: textTitle), //Montrserrat mobile/Montrserrat 19-24

  headlineMedium: GoogleFonts.montserrat(
      fontSize: 19,
      fontWeight: FontWeight.w600,
      color: primarySubtitle), //Montrserrat mobile/Montrserrat 19-24

  headlineSmall: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: primaryTextLabel), //Poppins mobile/Poppins Semi 19-24

  titleLarge: GoogleFonts.montserrat(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: primarySubtitle), //Montrserrat mobile/Montrserrat SB 16-24

  titleMedium: GoogleFonts.montserrat(
    fontSize: 19,
    fontWeight: FontWeight.w500,
  ),

  titleSmall: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ), //Poppins in my activity

  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: primarySubtitle,
  ),

  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),

  bodySmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textTitle,
  ),

  labelLarge: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  ),

  labelMedium: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),

  labelSmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),

  // displayLarge: GoogleFonts.montserrat(
  //   fontSize: 24,
  //   fontWeight: FontWeight.w600,
  // ), //Montrserrat mobile/Montrserrat 19-24

  displayMedium: GoogleFonts.montserrat(
    fontSize: 16,
  ),
  displaySmall: GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
  ),
);
