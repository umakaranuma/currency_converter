import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/bloc/currency_cubit.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/bloc/currency_state.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/models/currency_model.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  CurrencyConverterScreenState createState() => CurrencyConverterScreenState();
}

class CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String baseCurrency = 'USD'; // Default base currency
  double amount = 1.0; // Default amount
  final TextEditingController amountController = TextEditingController();

  // List to hold the target currencies
  List<String> targetCurrencies = ['EUR']; // Initially one currency

  @override
  void initState() {
    super.initState();
    amountController.text = amount.toString();
    // Fetch currency rates when the screen initializes
    context.read<CurrencyCubit>().fetchConversionRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Exchanger')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Insert Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value) ?? 1.0;
                });
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CurrencyLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dropdown for Base Currency
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: baseCurrency,
                              items: state.rates.map((Currency currency) {
                                return DropdownMenuItem<String>(
                                  value: currency.code,
                                  child: Row(
                                    children: [
                                      Text(currency.code),
                                      const SizedBox(width: 8),
                                      // Add flag or icon for each currency (optional)
                                    ],
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Base Currency',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  baseCurrency = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // List of target currencies with conversion amounts
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: targetCurrencies.length,
                        itemBuilder: (context, index) {
                          return _buildTargetCurrencyRow(
                            state.rates,
                            targetCurrencies[index],
                            (newValue) {
                              setState(() {
                                targetCurrencies[index] = newValue!;
                              });
                            },
                            () {
                              setState(() {
                                targetCurrencies.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // Button to add more converters
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              targetCurrencies
                                  .add('EUR'); // Default added currency
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('+ ADD CONVERTER'),
                        ),
                      ),
                    ],
                  );
                } else if (state is CurrencyError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each target currency row
  Widget _buildTargetCurrencyRow(List<Currency> rates, String selectedCurrency,
      ValueChanged<String?> onCurrencyChanged, VoidCallback onDelete) {
    double convertedAmount = _calculateConversion(rates, selectedCurrency);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              convertedAmount.toStringAsFixed(2),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 4,
            child: DropdownButtonFormField<String>(
              value: selectedCurrency,
              items: rates.map((Currency currency) {
                return DropdownMenuItem<String>(
                  value: currency.code,
                  child: Row(
                    children: [
                      Text(currency.code),
                      const SizedBox(width: 8),
                    ],
                  ),
                );
              }).toList(),
              onChanged: onCurrencyChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  // Calculate conversion for a specific target currency
  double _calculateConversion(List<Currency> rates, String targetCurrency) {
    final baseRate =
        rates.firstWhere((rate) => rate.code == baseCurrency).value;
    final targetRate =
        rates.firstWhere((rate) => rate.code == targetCurrency).value;
    return (amount / baseRate) * targetRate;
  }
}
