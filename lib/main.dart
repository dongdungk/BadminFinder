// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../router.dart';

// ⭐️ 1. ViewModel들을 임포트합니다 (이전과 동일)
import '/map/viewmodel/search_viewmodel.dart';
import '/map/viewmodel/facility_detail_viewmodel.dart';

// ⭐️ 2. ViewModel이 필요로 하는 "Service"를 임포트합니다.
import '/map/service/facility_service.dart';

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

  //대회 api 서비스 생성
  final competitionApiService = CompetitionApiService();

  runApp(
    MultiProvider(
      providers: [
        // ⭐️ 4. SearchViewModel을 생성할 때, 위에서 만든 service를 전달합니다.
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(facilityService),
        ),

        // ⭐️ 5. FacilityDetailViewModel을 생성할 때도 *똑같은* service를 전달합니다.
        ChangeNotifierProvider(
          create: (_) => FacilityDetailViewModel(facilityService),
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
      routerConfig: goRouter,
      title: 'Victor App',
      // (기타 테마 설정...)
    );
  }
}
