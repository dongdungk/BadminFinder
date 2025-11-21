// lib/main.dart (최종 빌드 성공 버전)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

// ⭐️ Project-Relative Imports
import 'router.dart';
import 'login/service/auth_service.dart';
import 'login/viewmodel/login_viewmodel.dart';
import 'map/service/facility_service.dart';

// [Service Layer] - 별칭 사용
import 'map/service/facility_photo_service.dart' as Photo_Alias;
import 'map/service/facility_review_service.dart' as Review_Alias;

//커뮤니티 provider import
import 'community/service/competition/competition_api_service.dart';
import 'community/view_model/competition/competition_view_model.dart';
import 'community/view_model/freeboard/freeboard_view_model.dart';
import 'community/view_model/freeboard/writing_view_model.dart';
import 'community/view_model/news/news_view_model.dart';
import 'community/view_model/survey/survey_view_model.dart';

void main() {
  // ⭐️ 3. 두 ViewModel이 함께 사용할 FacilityService 객체를 *하나만* 생성합니다.
  final FacilityService facilityService = FacilityService();
  final AuthService authService = AuthService();

  // 별칭을 사용하여 클래스를 명확히 생성
  final Review_Alias.ReviewService reviewService = Review_Alias.ReviewService();
  final Photo_Alias.PhotoService photoService = Photo_Alias.PhotoService();

  //대회 api 서비스 생성
  final competitionApiService = CompetitionApiService();

  runApp(
    MultiProvider(
      providers: [
        // 2. [Auth Stream] - ⭐️ [FIX 3] StreamProvider 문법 오류 해결: create:로 스트림 생성
        StreamProvider<User?>(
          create: (context) => FirebaseAuth.instance.authStateChanges(), // ✅ FIX: create 사용
          initialData: authService.getCurrentUser(),
          lazy: false,
        ),

        // 3. [Login VM]
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(authService),
        ),

        // 4. [Detail VM]
        ChangeNotifierProvider(
          create: (_) => FacilityDetailViewModel(facilityService, photoService),
        ),


        //커뮤니티-자유게시판
        ChangeNotifierProvider(
          create: (_) => FreeBoardViewModel()..loadInitialData(),),
        ChangeNotifierProvider(
          create: (_) => CommentViewModel(),),

        //커뮤니티-대회
        ChangeNotifierProvider(
          create: (_) => CompetitionViewModel()..loadCompetitions(),),

        //커뮤니티-뉴스
        ChangeNotifierProvider(create: (_) => NewsViewModel()..loadNews()),

        //커뮤니티-설문조사
        ChangeNotifierProvider(
          create: (_) => SurveyViewModel()..loadSurvey(),),
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: goRouter,
    );
  }
}
