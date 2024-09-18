import 'package:currency_converter_mobil_app/core/theme_data/colour_scheme.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/presenters/widgets/confirmation_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/bloc/currency_cubit.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/bloc/currency_state.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/models/currency_model.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  CurrencyConverterScreenState createState() => CurrencyConverterScreenState();
}

class CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String baseCurrency = 'USD';
  double amount = 1.0;
  final TextEditingController amountController = TextEditingController();

  List<String> targetCurrencies = ['EUR'];

  @override
  void initState() {
    super.initState();
    amountController.text = amount.toString();

    context.read<CurrencyCubit>().fetchConversionRates();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Exchanger'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("INSERT AMOUNT:"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.backgroundDark
                    : AppColors.backgroundLight,
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          amount = double.tryParse(value) ?? 1.0;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  BlocBuilder<CurrencyCubit, CurrencyState>(
                    builder: (context, state) {
                      if (state is CurrencyLoading) {
                        return _buildShimmerDropdown();
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
                          underline: Container(),
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
            const SizedBox(height: 20),
            BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyLoading) {
                  return _buildShimmerCurrencyList();
                } else if (state is CurrencyLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CONVERT TO :"),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: targetCurrencies.length,
                        itemBuilder: (context, index) {
                          return _buildTargetCurrencyRow(
                            rates: state.rates,
                            selectedCurrency: targetCurrencies[index],
                            onCurrencyChanged: (newValue) {
                              setState(() {
                                targetCurrencies[index] = newValue!;
                              });
                            },
                            onDelete: () {
                              ConfirmationDialog.show(
                                context: context,
                                onDelete: () {
                                  setState(() {
                                    targetCurrencies.removeAt(index);
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              targetCurrencies.add('EUR');
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            '+ ADD CONVERTER',
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.textLight
                                    : AppColors.textDark),
                          ),
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

  _buildTargetCurrencyRow({
    required List<Currency> rates,
    required String selectedCurrency,
    required ValueChanged<String?> onCurrencyChanged,
    required VoidCallback onDelete,
  }) {
    double convertedAmount = _calculateConversion(rates, selectedCurrency);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.backgroundDark
                    : AppColors.backgroundLight,
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
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
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: selectedCurrency,
                    items: rates.map((Currency currency) {
                      return DropdownMenuItem<String>(
                        value: currency.code,
                        child: Text(currency.code),
                      );
                    }).toList(),
                    onChanged: onCurrencyChanged,
                    underline: Container(),
                    isDense: true,
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.errorColor),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  double _calculateConversion(List<Currency> rates, String targetCurrency) {
    final baseRate =
        rates.firstWhere((rate) => rate.code == baseCurrency).value;
    final targetRate =
        rates.firstWhere((rate) => rate.code == targetCurrency).value;
    return (amount / baseRate) * targetRate;
  }

  // Shimmer effect for dropdown
  Widget _buildShimmerDropdown() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 100,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  // Shimmer effect for currency list
  Widget _buildShimmerCurrencyList() {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      }),
    );
  }
}
