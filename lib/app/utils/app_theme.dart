import 'package:flutter/material.dart';

class AppThemes {
  // Light Theme
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    fontFamily: 'Montserrat',
    // Optional: Set a custom font
    textTheme: const TextTheme(
      displayMedium: TextStyle(
          fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w300),
      bodyMedium: TextStyle(
          fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w400),
      headlineMedium: TextStyle(
          fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(
          fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w600),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(
          fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        // borderSide: BorderSide(color: Colors.blue),
      ),
      labelStyle: TextStyle(
        fontSize: 14.0,
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize: 14.0,
        color: Colors.grey,
        fontWeight: FontWeight.w300,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
    ),
  );
}
