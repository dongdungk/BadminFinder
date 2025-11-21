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

// [ViewModel Layer]
import 'map/viewmodel/search_viewmodel.dart';
import 'map/viewmodel/facility_detail_viewmodel.dart';
import 'map/viewmodel/facility_review_viewmodel.dart';
import 'map/viewmodel/facility_photo_viewmodel.dart'; //


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env");

  // 1. Service 객체 생성
  final FacilityService facilityService = FacilityService();
  final AuthService authService = AuthService();

  // 별칭을 사용하여 클래스를 명확히 생성
  final Review_Alias.ReviewService reviewService = Review_Alias.ReviewService();
  final Photo_Alias.PhotoService photoService = Photo_Alias.PhotoService();

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

        // 5. [Review VM]
        ChangeNotifierProvider(
          create: (_) => FacilityReviewViewModel(reviewService),
        ),

        // 6. [Search VM]
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(facilityService),
        ),

        ChangeNotifierProvider(
          create: (_) => FacilityPhotoViewModel(photoService),
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: goRouter,
    );
  }
}