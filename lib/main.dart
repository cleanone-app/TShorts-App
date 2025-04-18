import 'package:flutter/material.dart';
import 'package:tshorts/screens/home_screen.dart';

void main() {
  runApp(const TShortsApp());
}

class TShortsApp extends StatelessWidget {
  const TShortsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TShorts',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
