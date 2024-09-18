import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor =
      Color(0xFF53AE56); // Your primary button color
  static const Color textDark = Color(0xFF242424); // Text color for light mode
  static const Color textLight = Colors.white; // Text color for dark mode
  static const Color backgroundDark =
      Colors.grey; // Background color for dark mode containers
  static const Color backgroundLight =
      Colors.white; // Background color for light mode containers
  static const Color borderColor = Colors.grey; // Border color for containers
  static const Color errorColor =
      Colors.red; // Color for error messages or icons
}

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.blue, // Primary color for light mode
  onPrimary: Colors.white, // Text on primary color
  secondary: Colors.green,
  onSecondary: Colors.white, // Text on background
  surface: Colors.grey.shade100, // Surface color
  onSurface: Colors.black,
  error: Colors.red,
  onError: Colors.white,
);

// Define a ColorScheme for Dark Mode
final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.blueGrey, // Primary color for dark mode
  onPrimary: Colors.black, // Text on primary color
  secondary: Colors.teal,
  onSecondary: Colors.black, // Text on background
  surface: Colors.grey.shade800, // Surface color
  onSurface: Colors.white,
  error: Colors.red.shade700,
  onError: Colors.black,
);
