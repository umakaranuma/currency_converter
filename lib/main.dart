import 'package:currency_converter_mobil_app/modules/home_screen/infra/bloc/currency_cubit.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/datasourses/home_datasource.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/presenters/home_screen.dart';
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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CurrencyConverterScreen(),
    );
  }
}
