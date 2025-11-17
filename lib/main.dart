// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../router.dart';

// ⭐️ 1. ViewModel들을 임포트합니다 (이전과 동일)
import '/map/viewmodel/search_viewmodel.dart';
import '/map/viewmodel/facility_detail_viewmodel.dart';

// ⭐️ 2. ViewModel이 필요로 하는 "Service"를 임포트합니다.
import '/map/service/facility_service.dart';

void main() {
  // ⭐️ 3. 두 ViewModel이 함께 사용할 FacilityService 객체를 *하나만* 생성합니다.
  final FacilityService facilityService = FacilityService();

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

        // (나중에 다른 ViewModel이 생기면 여기에 추가...)
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