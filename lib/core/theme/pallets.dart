import 'package:flutter/material.dart';

abstract class Pallets {
  static const primary = Color(0xFF0E315D);
  static const primaryLight = Color(0xFF1A4B87);
  static const primaryDark = Color(0xFF069D16);
  static const lightBlue = Color(0xFF14B0D2);
  static const errorRed = Color(0xFFC62C2C);
  static const successGreen = Color(0xFF0F8345);
  static const mildBlue = Color(0xFFD5EAF3);
  static const orange = Color(0xFFEF673F);
  static const darkorange = Color(0xFFB12800);
  static const darkblue = Color(0xFF0E315D);
  static const midblue = Color(0xFFEDFAFF);
  static const blue = Color(0xFF0E315D);
  static const midorange = Color(0xFFFEF3EE);
  static const normalwhite = Color(0xffffffff);

  // static const darkOrange = Color(0xFFEEB21A);
  static const secondary = Color(0xFFf7653e);
  static const crimson = Color(0xFFe82c2b);
  static const secondary2 = Color(0xFFF8801E);
  static const secondaryLight = Color(0xFFf7653e);
  static const transparentOrage = Color(0xFFFFF8EC);

  // static const secondary = Color(0xFFC1A269);
  static const secondaryDark = Color(0xFFA47A46);

  // static const seconDaryLight = Color(0xFFF4EFE1);

  static const bgDark = Color(0xFF121212);
  static const surfaceDark = Color(0xff232325);

  static const darkGrey = Color(0xff18191B);
  static const lightGrey = Color(0xffF8F8F9);
  static const buttonGrey = Color(0xffF2F2F3);
  static const grey35 = Color(0xff55585E);
  static const grey60 = Color(0xff94989E);
  static const grey75 = Color(0xffBCBFC2);
  static const grey90 = Color(0xffE4E5E7);
  static const grey95 = Color(0xffE4E5E7);

  // static const primaryLight = Color(0xFFE2ECE4);
  static const maybeBlack = Color(0xFF101010);
  static const black = Colors.black;
  static const red = Colors.red;
  static const paymentBg = Color(0xffFAF7F7);
  static const white = Colors.white;
  static const grey = Color(0xff6D6D6D);
  static const chatTextFiledGrey = Color(0xffF7F7FC);
  static const searchGrey = Color(0xffF3F3F3);
  static const onboardingTextWhite = Color(0xfbF7F9FA);
  static const borderGrey = Color(0xffCCCCCC);
  static const unselectedGrey = Color(0xffB4B4B4);
  static const navBarColor = Color(0xffFAFAFA);
  static const otpBorderGrey = Color(0xffE6E6E6);
  static const hintGrey = Color(0xff868686);
  static const error = Color(0xffCA1818);

  static const spinBg1 = Color(0xFF9065fd);
  static const spinBg2 = Color(0xFFffc564);
  static const spinBg3 = Color(0xFF7ec4f8);
  static const spinBg4 = Color(0xFF5127a7);

  static const MaterialColor kToDark = MaterialColor(
    0xff09447f,
    <int, Color>{
      50: Color(0xff083d72),
      100: Color(0xff073666),
      200: Color(0xff063059),
      300: Color(0xff05294c),
      400: Color(0xff052240),
      500: Color(0xff041b33),
      600: Color(0xff031426),
      700: Color(0xff020e19),
      800: Color(0xff01070d),
      900: Color(0xff000000),
    },
  );
  static const MaterialColor kToLight = MaterialColor(
    0xff09447f,
    <int, Color>{
      50: Color(0xff22578c),
      100: Color(0xff3a6999),
      200: Color(0xff537ca5),
      300: Color(0xff6b8fb2),
      400: Color(0xff84a2bf),
      500: Color(0xff9db4cc),
      600: Color(0xffb5c7d9),
      700: Color(0xffcedae5),
      800: Color(0xffe6ecf2),
      900: Color(0xffffffff),
    },
  );

  static List<Color> spinBackgroundColors = [
    spinBg1,
    spinBg2,
    spinBg3,
    spinBg4,
  ];

  static Color selectSpinBackgroundColor(int index) {
    final actualIndex = index % spinBackgroundColors.length;
    return spinBackgroundColors[actualIndex];
  }
}
