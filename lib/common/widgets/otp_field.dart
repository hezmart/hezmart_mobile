import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../core/theme/pallets.dart';

class OtpField extends StatelessWidget {
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool useNativeKeyboard;
  final bool obscureText;
  final int count;
  final TextEditingController? controller;

  OtpField({
    Key? key,
    this.onCompleted,
    this.validator,
    this.count = 4,
    this.obscureText = false,
    this.useNativeKeyboard = true,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  final defaultPinTheme = PinTheme(
    width: 60.w,
    height: 60,
    margin: EdgeInsets.symmetric(horizontal: 5.w),
    textStyle: TextStyle(
      fontSize: 24.sp,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    // decoration: const BoxDecoration(
    //   // color: Pallets.black,
    //   border: Border(bottom: BorderSide(width: 2,color: Colors.black)),
    // ),
    decoration: BoxDecoration(
        // color: Pallets.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Pallets.grey),
        boxShadow: [
          BoxShadow(
            color: Pallets.lightGrey.withOpacity(0.4),
            offset: const Offset(1, 1),
            blurRadius: 2,
            spreadRadius: 1,
          )
        ]),
  );

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyWith(
      textStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
          // color: Pallets.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Pallets.grey),
          boxShadow: [
            BoxShadow(
              color: Pallets.lightGrey.withOpacity(0.4),
              offset: const Offset(1, 1),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ]),
    );

    final submittedPinTheme = focusedPinTheme;

    return Pinput(
      obscureText: obscureText,
      length: count,
      obscuringWidget: const Text(
        '⬤',
        style: TextStyle(fontSize: 12),
      ),
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      controller: controller,
      useNativeKeyboard: useNativeKeyboard,

      ///For autofill on otp received
      // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      onChanged: onChanged,

      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      validator: validator,

      //     (s) {
      //   ///TODO(TAMUNOR): check for the response from api and display the error with this
      //   // return s == '2222' ? null : 'Pin is incorrect';
      // },
      onCompleted: onCompleted,
    );
  }
}
