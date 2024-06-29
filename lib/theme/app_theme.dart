import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.light, // Set the theme to dark
  //scaffoldBackgroundColor: const Color(0xFF000000), // Pure black background
  primarySwatch: Colors.grey,   // Define primary color scheme
  hintColor: Colors.teal,       // Define accent color (optional)
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Set text color for body text
  ),
);
