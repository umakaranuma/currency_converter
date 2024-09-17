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
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Exchanger')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("INSERT AMOUNT:"),
            const SizedBox(height: 10),
            // Single container with TextField and Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                border:
                    Border.all(color: Colors.grey), // Border for the container
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Left side: TextField for amount
                  Expanded(
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        // labelText: 'Insert Amount',
                        border: InputBorder
                            .none, // Remove inner border to make it seamless
                      ),
                      onChanged: (value) {
                        setState(() {
                          amount = double.tryParse(value) ?? 1.0;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                      width: 16), // Space between TextField and Dropdown

                  // Right side: Dropdown for base currency
                  BlocBuilder<CurrencyCubit, CurrencyState>(
                    builder: (context, state) {
                      if (state is CurrencyLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is CurrencyLoaded) {
                        return DropdownButton<String>(
                          value: baseCurrency,
                          items: state.rates.map((Currency currency) {
                            return DropdownMenuItem<String>(
                              value: currency.code,
                              child: Text(currency.code),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              baseCurrency = newValue!;
                            });
                          },
                          underline: Container(), // Remove default underline
                          isDense: true,
                        );
                      } else if (state is CurrencyError) {
                        return const Text('Error loading currencies');
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Add some spacing

            BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CurrencyLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CONVERT TO :"),
                      const SizedBox(height: 10),

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

  _buildTargetCurrencyRow(
    List<Currency> rates,
    String selectedCurrency,
    ValueChanged<String?> onCurrencyChanged,
    VoidCallback onDelete,
  ) {
    double convertedAmount = _calculateConversion(rates, selectedCurrency);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container with Converted Amount and Dropdown
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                border:
                    Border.all(color: Colors.grey), // Border for the container
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Row(
                children: [
                  // Left: Converted amount text
                  Expanded(
                    flex: 3,
                    child: Text(
                      convertedAmount.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16), // Space between text and dropdown

                  // Right: Dropdown for selecting target currency
                  DropdownButton<String>(
                    value: selectedCurrency,
                    items: rates.map((Currency currency) {
                      return DropdownMenuItem<String>(
                        value: currency.code,
                        child: Text(currency.code), // Currency code
                      );
                    }).toList(),
                    onChanged: onCurrencyChanged,
                    underline: Container(), // Remove the default underline
                    isDense: true, // Make it compact
                    icon: const Icon(
                        Icons.arrow_drop_down), // Custom dropdown icon
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
              width: 8), // Space between the container and delete button

          // Delete Icon Button (outside the container)
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
