// lib/main.dart (최종 빌드 성공 버전)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ⭐️ Project-Relative Imports
import 'router.dart';

// Project Services & ViewModels
import 'map/viewmodel/facility_detail_viewmodel.dart';
import 'login/service/auth_service.dart';
import 'login/viewmodel/login_viewmodel.dart';
import 'map/service/facility_service.dart';

import 'map/service/facility_photo_service.dart' as Photo_Alias;
import 'map/service/facility_review_service.dart' as Review_Alias;

// 커뮤니티 ViewModel
import 'community/view_model/freeboard/freeboard_view_model.dart';
import 'community/view_model/news/news_view_model.dart';

// 💡 Firebase 초기화 및 객체 생성 순서 조정 (오류 해결)
void main() async {
  // 1. Flutter 바인딩 초기화 및 main 함수를 비동기로 만듦
  WidgetsFlutterBinding.ensureInitialized();

  // 2. .env 파일 로드 (가장 먼저 수행)
  await dotenv.load(fileName: ".env");

  // 3. 🚨 Firebase 초기화: 모든 Firebase 서비스 사용 전에 완료
  await Firebase.initializeApp(); // 💡 options는 firebase_options.dart에서 자동 가져옴

  // 4. 초기화가 완료된 후, Firebase 인스턴스에 접근하는 서비스 객체 생성
  final FacilityService facilityService = FacilityService();
  final AuthService authService = AuthService();

  final Review_Alias.ReviewService reviewService = Review_Alias.ReviewService();
  final Photo_Alias.PhotoService photoService = Photo_Alias.PhotoService();
  // final competitionApiService = CompetitionApiService();

  runApp(
    MultiProvider(
      providers: [
        // 1. [Auth Stream]
        StreamProvider<User?>(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
          initialData: authService.getCurrentUser(),
          lazy: false,
        ),

        // 2. [Login VM]
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(authService),
        ),

        // 3. [Facility Detail VM] - ReviewService가 생성자에 필요하다고 가정하고 추가
        ChangeNotifierProvider(
          create: (_) => FacilityDetailViewModel(facilityService, photoService, reviewService),
        ),

        //자유게시판 Firestore CRUD
        ChangeNotifierProvider(
          create: (_) => FreeBoardViewModel(),
        ),

        //뉴스 ViewModel
        ChangeNotifierProvider(
          create: (_) => NewsViewModel()..loadNews(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // goRouter는 router.dart 파일에서 임포트됩니다.
    return MaterialApp.router(
      title: 'Facility Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: goRouter,
    );
  }
}