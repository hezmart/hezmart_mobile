import 'dart:developer';

import 'package:form_field_validator/form_field_validator.dart';

class ConfirmPasswordValidator extends TextFieldValidator {
  ConfirmPasswordValidator(
      {required String errorText, required this.comparedPassword})
      : super(errorText);

  final String comparedPassword;

  // @override
  // bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    log('COMPARED PASSWORD: $comparedPassword');
    log('PASSWORD: $value');
    log((comparedPassword.toString() == value.toString()).toString());
    return comparedPassword.toString() == value.toString();
  }
}

class MinAmountValidator extends TextFieldValidator {
  MinAmountValidator({
    required String errorText,
    required this.minAmount,
  }) : super(errorText);

  final double minAmount;

  // @override
  // bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    var amount = double.parse(value ?? '0');
    // logger.i(amount.toString());
    return amount >= minAmount;
  }
}
