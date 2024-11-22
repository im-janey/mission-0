import 'package:flutter/material.dart';

import 'screens/intro/splash1.dart';

// 공통 색상 정의
const primaryColor = Color(0xFF4A90E2);
const secondaryColor = Color(0xFF50E3C2);

// 공통 텍스트 스타일
const textTheme = TextTheme(
  bodyLarge: TextStyle(
    fontFamily: 'Nanum_Gothic,Parkinsans',
    color: Colors.black,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Nanum_Gothic,Parkinsans',
    color: Colors.black,
  ),
);

const darkTextTheme = TextTheme(
  bodyLarge: TextStyle(
    fontFamily: 'Nanum_Gothic,Parkinsans',
    color: Colors.white,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Nanum_Gothic,Parkinsans',
    color: Colors.white,
  ),
);

// 공통 앱바 테마
AppBarTheme appBarTheme(Color backgroundColor) => AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
    );

// 라이트 테마
final ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color(0xFFF9FAFB),
  appBarTheme: appBarTheme(const Color(0xFFF9FAFB)),
  textTheme: textTheme,
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
  ),
  indicatorColor: primaryColor,
  useMaterial3: true,
);

// 다크 테마
final ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: appBarTheme(const Color(0xFF121212)),
  textTheme: darkTextTheme,
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: Color(0xFF1E1E1E),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.white,
  ),
  indicatorColor: primaryColor,
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
