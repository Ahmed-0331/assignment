import 'package:flutter/material.dart';
import 'screens/bmi_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(useMaterial3: true),
      home: const BMIScreen(),
    );
  }
}
