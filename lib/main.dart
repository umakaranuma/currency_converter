import 'package:currency_converter_mobil_app/core/theme_data/colour_scheme.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/bloc/currency_cubit.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/datasourses/home_datasource.dart';
import 'package:currency_converter_mobil_app/modules/splash_screen/presenters/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CurrencyCubit>(create: (context) {
      return CurrencyCubit(homeDataSource: HomeDataSource());
    }),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      themeMode:
          ThemeMode.light, // Automatically switch based on system settings
      theme: ThemeData(
        colorScheme: lightColorScheme, // Use light color scheme
        useMaterial3: true, // Use Material 3 design
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: lightColorScheme.onSurface),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme, // Use dark color scheme
        useMaterial3: true, // Use Material 3 design
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: darkColorScheme.onSurface),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
