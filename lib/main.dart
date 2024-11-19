import 'package:flutter/material.dart';

import 'screens/intro/splash1.dart';

// Light and Dark Theme
ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFF2B4E8D),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2B4E8D),
    secondary: Color(0xFF6C97CB),
    surface: Color(0xFFF5F6FA),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
  ),
  indicatorColor: const Color(0xFF2B4E8D),
  useMaterial3: true,
);

ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xFF2B4E8D),
  scaffoldBackgroundColor: const Color(0xFF1B2644),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1B2644),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF2B4E8D),
    secondary: Color(0xFFB3C7E2),
    surface: Color(0xFF1B2644),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.white,
  ),
  indicatorColor: const Color(0xFF2B4E8D),
  useMaterial3: true,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mission #0',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const Splash1(),
    );
  }
}
