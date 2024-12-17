import 'package:flutter/services.dart';

/// Custom Input Formatter to Force Uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(), // Convert input to uppercase
      selection: newValue.selection,
    );
  }
}