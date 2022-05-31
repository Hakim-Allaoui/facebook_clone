import 'package:flutter/material.dart';

class S {
  static Map<String, Color> hkColors = {
    "black": const Color(0XFF18191B),
    "white": const Color(0xffffffff),
    "dark": const Color(0xff222524),
    "light": const Color(0xffF1F2F6),
    "darkGrey": const Color(0xff373a39),
    "lightGrey": const Color(0xffB0B4B7),
    "blue": const Color(0xff2C88FF),
  };

  static MColor colors = MColor();

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    // primarySwatch: colors.,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: S.colors.scaffoldBackgroundLight,
    appBarTheme: AppBarTheme(backgroundColor: S.colors.white),
    textTheme: ThemeData.light().textTheme.copyWith(),
    dividerTheme: const DividerThemeData(indent: 10.0, endIndent: 10.0, color: Color(0xffB0B4B7)),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: S.colors.scaffoldBackgroundDark,
    appBarTheme: AppBarTheme(backgroundColor: S.colors.dark),
    textButtonTheme: const TextButtonThemeData(),
    textTheme: ThemeData.dark().textTheme.copyWith(),
    dividerTheme: const DividerThemeData(indent: 10.0, endIndent: 10.0),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    dividerColor: S.colors.lightGrey,
  );
}

class MColor {
  Color dark = const Color(0xff222524);
  Color darker = const Color(0xff1C1F1E);
  Color light = const Color(0xffF1F2F6);
  Color black = const Color(0XFF18191B);
  Color white = const Color(0xffffffff);
  Color darkGrey = const Color(0xff373a39);
  Color lightGrey = const Color(0xffB0B4B7);
  Color blue = const Color(0xff2C88FF);
  Color button = const Color(0xff8ab4f8);
  Color online = const Color(0xFF4BCB1F);
  Color scaffoldBackgroundLight = const Color(0XFFC9CCD1);
  Color scaffoldBackgroundDark = const Color(0XFF18191B);
}
