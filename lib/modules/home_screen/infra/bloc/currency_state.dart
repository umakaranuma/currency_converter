// States
import 'package:currency_converter_mobil_app/modules/home_screen/infra/models/currency_model.dart';

abstract class CurrencyState {
  const CurrencyState();
}

class CurrencyLoading extends CurrencyState {
  const CurrencyLoading();
}

class CurrencyEmpty extends CurrencyState {
  const CurrencyEmpty();
}

class CurrencyLoaded extends CurrencyState {
  final List<Currency> rates;
  final List<String> preferredCurrencies;

  CurrencyLoaded({required this.rates, required this.preferredCurrencies});
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);
}
