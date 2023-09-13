import 'package:flutter/material.dart';

const fruitOptions = <String>[
  'Apple',
  'Banana',
  'Strawberry',
  'Cherry',
  'Orange',
  'Raspberry',
];

final ThemeData themeData = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.green,
    onPrimary: Colors.white,
    secondary: Colors.lightGreen,
    onSecondary: Colors.white,
    error: Colors.red[900]!,
    onError: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.green,
    onSurface: Colors.brown[700]!,
    shadow: Colors.brown[300]!,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.green[100],
    focusColor: Colors.green,
    iconColor: Colors.green,
    contentPadding: const EdgeInsets.all(16),
    errorStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.red[900],
    ),
    hintStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green[300]!,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.green,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red[900]!,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red[900]!,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: Colors.green,
    cursorColor: Colors.green,
    selectionColor: Colors.green[300],
  ),
  dividerColor: Colors.green,
);
