// lib/main.dart (최종 빌드 성공 버전)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

// ⭐️ Project-Relative Imports
import 'router.dart';
import 'login/service/auth_service.dart';
import 'login/viewmodel/login_viewmodel.dart';
import 'map/service/facility_service.dart';
import 'map/viewmodel/facility_detail_viewmodel.dart';
// 💡 FacilityReviewViewModel이 정의된 파일을 임포트해야 합니다. (추정 경로)
import 'map/viewmodel/facility_review_viewmodel.dart';
// lib/main.dart 상단
import 'map/viewmodel/facility_photo_viewmodel.dart'; //
import 'map/viewmodel/search_viewmodel.dart';

import 'login/view/login_view.dart';

// [Service Layer] - 별칭 사용
import 'map/service/facility_photo_service.dart' as Photo_Alias;
import 'map/service/facility_review_service.dart' as Review_Alias;


//커뮤니티 provider import
import 'community/service/competition/competition_api_service.dart';
import 'community/view_model/competition/competition_view_model.dart';
import 'community/view_model/freeboard/freeboard_view_model.dart';
// 💡 WritingViewModel을 CommentViewModel 대신 등록하고, 임포트 이름을 WritingViewModel로 변경
import 'community/view_model/freeboard/writing_view_model.dart';
import 'community/view_model/news/news_view_model.dart';
import 'community/view_model/survey/survey_view_model.dart';

// 💡 Firebase 초기화 및 객체 생성 순서 조정 (오류 해결)
void main() async {
  // 1. Flutter 바인딩 초기화 및 main 함수를 비동기로 만듦
  WidgetsFlutterBinding.ensureInitialized();

  // 2. .env 파일 로드 (가장 먼저 수행)
  await dotenv.load(fileName: ".env");


  // 3. Firebase 초기화: 모든 Firebase 서비스 사용 전에 완료
  await Firebase.initializeApp(); // 💡 options는 firebase_options.dart에서 자동 가져옴

  // ⭐️⭐️⭐️ 2. App Check 초기화 추가 ⭐️⭐️⭐️
  await FirebaseAppCheck.instance.activate(
    // 💡 테스트 시 DebugProvider를 사용하고, 실제 배포 시 Play Integrity 등으로 변경
    androidProvider: AndroidProvider.debug,

  );

  // 4. 초기화가 완료된 후, Firebase 인스턴스에 접근하는 서비스 객체 생성
  final FacilityService facilityService = FacilityService();
  final AuthService authService = AuthService();

  final Review_Alias.ReviewService reviewService = Review_Alias.ReviewService();
  final Photo_Alias.PhotoService photoService = Photo_Alias.PhotoService();
  final competitionApiService = CompetitionApiService();



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

        // 3. [Facility Detail VM]
        ChangeNotifierProvider(
          create: (_) => FacilityDetailViewModel(facilityService, photoService, reviewService),
        ),

        // ⭐️⭐️⭐️ 4. [Facility Review VM] - ProviderNotFoundException 오류 해결 ⭐️⭐️⭐️
        // reviewService를 인자로 사용하여 Provider에 등록합니다.
        ChangeNotifierProvider(
          create: (_) => FacilityReviewViewModel(reviewService),
        ),

        // ⭐️⭐️⭐️ 5. [Facility Photo VM] - 현재 오류 해결 ⭐️⭐️⭐️
        // photoService를 인자로 사용하여 Provider에 등록합니다.
        ChangeNotifierProvider(
          create: (_) => FacilityPhotoViewModel(photoService),
        ),

        // 5. [Community ViewModels]
        ChangeNotifierProvider(
          create: (_) => FreeBoardViewModel()..loadInitialData(),
        ),
        // 💡 CommentViewModel 대신 WritingViewModel을 등록 (파일명 기반 추정)

        ChangeNotifierProvider(
          // SearchViewModel이 FacilityService를 필요로 한다고 가정
          create: (_) => SearchViewModel(facilityService),
        ),

        ChangeNotifierProvider(
          create: (_) => CompetitionViewModel()..loadCompetitions(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsViewModel()..loadNews(),
        ),
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