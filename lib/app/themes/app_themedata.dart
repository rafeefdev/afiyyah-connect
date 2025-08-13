import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  cardTheme: _cardThemeData(),
  floatingActionButtonTheme: _floatingActionButtonThemeData(),
  inputDecorationTheme: _inputDecorationTheme(),
  // outlinedButtonTheme: _outlinedButtonThemeData(),
  tabBarTheme: TabBarThemeData(dividerHeight: 0),
  // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal, ),
);

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1.5, color: ThemeData().primaryColor),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  );
}

CardThemeData _cardThemeData() {
  return CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}

FloatingActionButtonThemeData _floatingActionButtonThemeData() {
  return const FloatingActionButtonThemeData(
    elevation: 2,
    highlightElevation: 4,
  );
}
