// lib/main.dart (Firebase 완전 정상 버전)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'router.dart';

// Project Services & ViewModels
import 'map/viewmodel/facility_detail_viewmodel.dart';
import 'login/service/auth_service.dart';
import 'login/viewmodel/login_viewmodel.dart';
import 'map/service/facility_service.dart';

import 'map/service/facility_photo_service.dart' as Photo_Alias;
import 'map/service/facility_review_service.dart' as Review_Alias;

import 'community/service/competition/competition_api_service.dart';
import 'community/view_model/competition/competition_view_model.dart';
import 'community/view_model/freeboard/freeboard_view_model.dart';
import 'community/view_model/freeboard/writing_view_model.dart';
import 'community/view_model/news/news_view_model.dart';
import 'community/view_model/survey/survey_view_model.dart';

void main() async {
  // 🔥 비동기 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Firebase 초기화 (필수)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔥 .env 로드 (사용 중이라면 반드시 필요)
  await dotenv.load();

  // Services
  final FacilityService facilityService = FacilityService();
  final AuthService authService = AuthService();

  final Review_Alias.ReviewService reviewService = Review_Alias.ReviewService();
  final Photo_Alias.PhotoService photoService = Photo_Alias.PhotoService();
  final competitionApiService = CompetitionApiService();

  runApp(
    MultiProvider(
      providers: [
        // ⭐ AuthState StreamProvider
        StreamProvider<User?>(
          create: (_) => FirebaseAuth.instance.authStateChanges(),
          initialData: FirebaseAuth.instance.currentUser,
          lazy: false,
        ),

        // Login
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(authService),
        ),

        // Facility detail
        ChangeNotifierProvider(
          create: (_) => FacilityDetailViewModel(
            facilityService,
            photoService,
          ),
        ),

        // 자유게시판
        ChangeNotifierProvider(
          create: (_) => FreeBoardViewModel()..loadInitialData(),
        ),
        ChangeNotifierProvider(
          create: (_) => CommentViewModel(),
        ),

        // 대회
        ChangeNotifierProvider(
          create: (_) => CompetitionViewModel()..loadCompetitions(),
        ),

        // 뉴스
        ChangeNotifierProvider(
          create: (_) => NewsViewModel()..loadNews(),
        ),

        // 설문조사
        ChangeNotifierProvider(
          create: (_) => SurveyViewModel()..loadSurvey(),
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
    return MaterialApp.router(
      title: 'Facility Booking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: goRouter,
    );
  }
}
