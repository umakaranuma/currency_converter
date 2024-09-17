class Currency {
  final String code;
  final double value;

  Currency({
    required this.code,
    required this.value,
  });

  // Factory constructor to create Currency from JSON
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      // Safely handling both int and double for the 'value' field
      value: (json['value'] is int)
          ? (json['value'] as int).toDouble()
          : json['value'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'value': value,
    };
  }
}
