import 'package:flutter/material.dart';

import 'colour_scheme.dart';
import 'text_theme.dart';

var elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith(
      (state) {
        if (state.contains(WidgetState.pressed)) {
          return secondaryDefault;
        }
        return primaryDefault;
      },
    ),

    textStyle: WidgetStatePropertyAll(textTheme.labelMedium),
    // maximumSize: const WidgetStatePropertyAll(Size(345, 48)),
    fixedSize: const WidgetStatePropertyAll(
      Size.fromHeight(48),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: 12, horizontal: 18),
    ),
  ),
);
