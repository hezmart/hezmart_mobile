import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class CustomCurrencyInputFormatter extends TextInputFormatter {
  final String? currency;

  CustomCurrencyInputFormatter({this.currency});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    String currentValue = '';
    final newDouble = double.tryParse(newValue.text);
    String newString = NumberFormat("#,##0.##").format(newDouble);

    // currentValue = '${selectedCurrencySign(currency ?? '\$')}$newString';
    currentValue = '${'\$'}$newString';

    return TextEditingValue(
      text: currentValue,
      selection: TextSelection.collapsed(offset: currentValue.length),
    );
  }
}
