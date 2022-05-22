import 'package:flutter/services.dart';

class QuantityInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.replaceAll('.', '').length > 6) {
      return oldValue;
    }
    //  final String newParsed = newValue.text.replaceAll(',', '.');

    // final List<String> parts = newParsed.split('.');
    // if (parts.length == 1) {
    //   if (parts.first.length > 5) {
    //     return oldValue;
    //   }
    // } else {
    //   if (parts.first.length > 5) {
    //     return oldValue;
    //   }
    //   if (parts.last.length > 3) {
    //     //allow 3 decimal places
    //     return oldValue;
    //   }
    // }
    return newValue;
  }
}
