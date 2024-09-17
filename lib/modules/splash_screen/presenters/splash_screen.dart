import 'dart:async';
import 'package:flutter/material.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/presenters/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the main screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const CurrencyConverterScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access the current theme's brightness (light or dark)
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? Colors.black
          : Colors.white, // Dynamically change background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Currency Converter Logo or Icon
            Icon(
              Icons.monetization_on,
              color: isDarkMode
                  ? Colors.green
                  : Colors.blue, // Change icon color based on the theme
              size: 100,
            ),
            const SizedBox(height: 20),
            // App Name
            Text(
              'Currency Converter',
              style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : Colors.black, // Change text color based on the theme
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
