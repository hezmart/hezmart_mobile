import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoneyInputFormatter extends TextInputFormatter {
  final NumberFormat _moneyFormatter = NumberFormat.currency( symbol: '');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final int selectionIndex = newValue.selection.end;

    String formatText(String input) {
      final number = int.tryParse(input);
      if (number != null) {
        return _moneyFormatter.format(number);
      } else {
        return input;
      }
    }

    final String formattedValue = formatText(newValue.text);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formatText(newValue.text.substring(0, selectionIndex)).length),
    );
  }
}