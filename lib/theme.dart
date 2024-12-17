import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trueworthfinance/custom/colors.dart';


ThemeData appTheme = ThemeData(
  // Primary color for UI elements
  primaryColor: primary,

  fontFamily: GoogleFonts.roboto().fontFamily,
  // Updated for Material 3: Secondary color
  colorScheme: const ColorScheme.light(
    primary: primary,       // Primary color
    secondary: secondary,  // Secondary color (replaces accentColor)
  ),

  // Background color for the app
  backgroundColor: primary,

  // AppBar theme
  appBarTheme: const AppBarTheme(
    color: primary, // AppBar background color
    iconTheme: IconThemeData(color: secondary3), // Icon color
    titleTextStyle: TextStyle(
      color: secondary3, // Text color in AppBar
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Typography - Define general text styles across the app
  typography: Typography.material2018(
    platform: TargetPlatform.android, // Or other platforms if needed
  ).copyWith(
    black: const TextTheme(
      bodyText1: TextStyle(
        color: secondary3, // Text color for body text
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: secondary, // Lighter text color for some body text
        fontSize: 14,
      ),
      headline1: TextStyle(
        color: primary, // Text color for large headings
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: primary, // Text color for smaller headings
        fontSize: 24,
      ),
    ),
  ),

  // Text theme
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: secondary3,
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      color: secondary,
      fontSize: 14,
    ),
    headline1: TextStyle(
      color: primary,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: primary,
      fontSize: 24,
    ),
  ),

  // Button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(secondary),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      elevation: MaterialStateProperty.all(5),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
      side: MaterialStateProperty.all(BorderSide(color: secondary, width: 2)),
    ),
  ),

  // Icon theme
  iconTheme: const IconThemeData(
    color: secondary3, // Color for all icons
  ),

  // Input decoration (TextFields, Form fields)
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primary),
    ),
    labelStyle: TextStyle(color: secondary),
  ),

  // Scaffold background color
  scaffoldBackgroundColor: primary,
);

