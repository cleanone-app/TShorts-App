// main.dart import 'package:flutter/material.dart'; import 'package:tshorts/screens/home_screen.dart';

void main() { runApp(const TShortsApp()); }

class TShortsApp extends StatelessWidget { const TShortsApp({super.key});

@override Widget build(BuildContext context) { return MaterialApp( title: 'TShorts', theme: ThemeData.dark(), home: const HomeScreen(), debugShowCheckedModeBanner: false, ); } }

// home_screen.dart import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget { const HomeScreen({super.key});

@override Widget build(BuildContext context) { return Scaffold( backgroundColor: Colors.black, body: Center( child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [ const Text( 'Welcome TShorts. This is New World.', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center, ), const SizedBox(height: 20), ElevatedButton( onPressed: () { // 텍스트 → 영상 생성 시작 }, style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), child: const Text('Create Shorts'), ), ], ), ), ); } }

// pubspec.yaml name: tshorts version: 1.0.0+1 description: TShorts - 자동 텍스트 쇼츠 생성 앱 environment: sdk: ">=2.17.0 <3.0.0"

dependencies: flutter: sdk: flutter flutter_tts: ^3.5.2 ffmpeg_kit_flutter: ^4.5.1 file_picker: ^6.1.1 path_provider: ^2.1.1 permission_handler: ^11.1.0

flutter: uses-material-design: true

