import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark, // Set the theme to dark
  primarySwatch: Colors.grey,   // Define primary color scheme
  hintColor: Colors.teal,
  useMaterial3: true,// Define accent color
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Set text color for body text
  ),
);
