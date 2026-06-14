import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AmarProshnoApp());
}

class AmarProshnoApp extends StatelessWidget {
  const AmarProshnoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amar Proshno',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}