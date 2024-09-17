// Cubit
import 'package:bloc/bloc.dart';
import 'package:currency_converter_mobil_app/core/exceptions/network_exceptions.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/bloc/currency_state.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/datasourses/home_datasource.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/models/currency_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Cubit
class CurrencyCubit extends Cubit<CurrencyState> {
  final HomeDataSource homeDataSource;
  static const String preferredCurrenciesKey = 'preferredCurrencies';

  CurrencyCubit({required this.homeDataSource})
      : super(const CurrencyLoading());

  // Fetch conversion rates and load preferred currencies from SharedPreferences
  Future<void> fetchConversionRates() async {
    emit(const CurrencyLoading());
    try {
      var result = await homeDataSource.getAllCurrancyData();

      result.when(success: (List<Currency> currencies) async {
        List<String> preferredCurrencies = await _loadPreferredCurrencies();
        emit(CurrencyLoaded(
            rates: currencies, preferredCurrencies: preferredCurrencies));
      }, failure: (NetworkExceptions error) {
        emit(CurrencyError(error.toString()));
      });
    } catch (e) {
      emit(CurrencyError('Error fetching data'));
    }
  }

  // Save a preferred target currency and update SharedPreferences
  Future<void> savePreferredCurrency(String currencyCode) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> preferredCurrencies = await _loadPreferredCurrencies();

    if (!preferredCurrencies.contains(currencyCode)) {
      preferredCurrencies.add(currencyCode);
      await prefs.setStringList(preferredCurrenciesKey, preferredCurrencies);
      emit(CurrencyLoaded(
        rates: (state as CurrencyLoaded).rates,
        preferredCurrencies: preferredCurrencies,
      ));
    }
  }

  // Delete a preferred target currency and update SharedPreferences
  Future<void> deletePreferredCurrency(String currencyCode) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> preferredCurrencies = await _loadPreferredCurrencies();

    if (preferredCurrencies.contains(currencyCode)) {
      preferredCurrencies.remove(currencyCode);
      await prefs.setStringList(preferredCurrenciesKey, preferredCurrencies);
      emit(CurrencyLoaded(
        rates: (state as CurrencyLoaded).rates,
        preferredCurrencies: preferredCurrencies,
      ));
    }
  }

  // Load preferred target currencies from SharedPreferences
  Future<List<String>> _loadPreferredCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(preferredCurrenciesKey) ?? [];
  }
}
