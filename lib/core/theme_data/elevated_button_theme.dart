import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Function to create ElevatedButtonThemeData based on the given ColorScheme
ElevatedButtonThemeData buildElevatedButtonTheme(ColorScheme colorScheme) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: colorScheme.onPrimary, // Text color
      backgroundColor: colorScheme.primary, // Background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      textStyle: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
