import 'dart:developer';
import 'package:currency_converter_mobil_app/core/configs/api_config.dart';
import 'package:currency_converter_mobil_app/core/exceptions/api_result.dart';
import 'package:currency_converter_mobil_app/core/exceptions/network_exceptions.dart';
import 'package:currency_converter_mobil_app/modules/home_screen/infra/models/currency_model.dart';

class HomeDataSource {
  ApiBaseRequsets apiBaseRequsets = ApiBaseRequsets();

  Future<ApiResult<List<Currency>>> getAllCurrancyData() async {
    try {
      var response = await apiBaseRequsets.get(
        'fca_live_Maf9gmErq2btvwGtHAs3QhmCPWr5y45l0hmSnjyK',
      );

      log(response.toString(), name: 'getAllCurrancyData');

      List<Currency> list = [];

      // Fix: Parse response['data'] as a Map instead of List
      if (response['data'] is Map) {
        // Loop through each entry in the response data map
        response['data'].forEach((key, value) {
          list.add(Currency.fromJson(value));
        });
      }

      return ApiResult.success(list);
    } catch (e) {
      log('Error: $e', name: 'getAllCurrancyData');
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
