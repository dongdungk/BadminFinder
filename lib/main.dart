import 'package:flutter/material.dart';
// ---!!! import 경로를 님의 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Main_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BadimFinder', // 님의 Repository 이름으로 변경
      theme: ThemeData(
        // ---!!! [수정] AppBar/Scaffold 기본 배경색 흰색으로 설정 !!!---
        // (피그마 시안과 일치시킴)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, // 아이콘 등 전경색
          elevation: 1.0, // 그림자
        ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // ---!!! [핵심] 앱의 첫 화면은 '뼈대'인 MainScreen 입니다 !!!---
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}