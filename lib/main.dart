import 'package:flutter/material.dart';
// 1. 'main_screen.dart' (snake_case)를 import 합니다.
import 'package:victor/map/view/Main_Screen.dart'; // 경로 확인 필요

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // AppBar 및 Scaffold 기본 배경색을 흰색으로 설정
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, // 아이콘 등 전경색
          elevation: 1.0,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      // 2. 앱의 첫 화면은 이제 'MainScreen'입니다.
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}