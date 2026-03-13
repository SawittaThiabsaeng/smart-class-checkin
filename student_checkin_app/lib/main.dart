import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/checkin_screen.dart';
import 'screens/finish_class_screen.dart';

void main() {
  runApp(const SmartClassApp());
}

class SmartClassApp extends StatelessWidget {
  const SmartClassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Class Check-in',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A11CB),
        ),
      ),

      themeMode: ThemeMode.light,

      initialRoute: '/',

      routes: {
        '/': (context) => const HomeScreen(),
        '/checkin': (context) => const CheckInScreen(),
        '/finish': (context) => const FinishClassScreen(),
      },
    );
  }
}