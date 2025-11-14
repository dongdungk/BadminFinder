import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'firebase_options.dart';
import 'login/viewModel/ViewModel.dart';
import 'login/view/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Kakao 초기화 (실제 앱 키로 교체!)
  KakaoSdk.init(nativeAppKey: 'f1f24c20f2a6ee0f128a105cd3deea79');

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 앱 실행
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BadminFinder',
      home: LoginPage(),
    );
  }
}