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
    primary: Colors.purple[900]!,
    onPrimary: Colors.white,
    secondary: Colors.lightGreen,
    onSecondary: Colors.white,
    error: Colors.red[900]!,
    onError: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.purple[900]!,
    onSurface: Colors.purple,
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
    fillColor: Colors.purple[100],
    focusColor: Colors.purple[900]!,
    iconColor: Colors.purple[900]!,
    contentPadding: const EdgeInsets.all(16),
    errorStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.red[900],
    ),
    hintStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.purple,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.purple[300]!,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.purple[900]!,
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
    selectionHandleColor: Colors.purple[900]!,
    cursorColor: Colors.purple[900]!,
    selectionColor: Colors.purple[300],
  ),
  dividerColor: Colors.purple[900]!,
);
