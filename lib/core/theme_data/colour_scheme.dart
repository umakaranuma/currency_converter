import 'package:flutter/material.dart';

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
