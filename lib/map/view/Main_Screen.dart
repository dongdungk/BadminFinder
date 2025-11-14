import 'package:flutter/material.dart';
// ---!!! [수정] 5개의 import 경로를 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Map_Main_Screen.dart';
import 'package:victor/map/view/Favorite_Screen.dart';
import 'package:victor/map/view/Search_Screen.dart';
import 'package:victor/map/view/Tagging_Main_Screen.dart'; // <-- [신규] 입출입 메인
import 'package:victor/map/view/Tagging_Success_Screen.dart'; // <-- [신규] 태그 성공

// TODO: Stats, Community, Profile 스크린 임포트

// ---!!! [핵심] 중첩 네비게이터를 위한 GlobalKey !!!---
GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // ---!!! [수정] 님의 프로토타입에 맞춰 '홈'(0번) 탭에서 시작 !!!---
  int _selectedIndex = 0;

  // 탭에 해당하는 라우트 이름
  final List<String> _tabRoutes = [
    '/', // 0: 홈 (지도)
    '/stats', // 1: 통계
    '/edit', // 2: 입출입 (태그 메인)
    '/community', // 3: 커뮤니티
    '/profile', // 4: 내 정보
  ];

  void _onBottomNavItemTapped(int index) {
    if (_selectedIndex == index) {
      mainNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
      mainNavigatorKey.currentState?.pushNamedAndRemoveUntil(
        _tabRoutes[index],
            (route) => false,
      );
    }
  }

  void _updateCurrentTab(String routeName) {
    int newIndex = _tabRoutes.indexOf(routeName);
    if (newIndex != -1 && newIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Navigator(
        key: mainNavigatorKey,
        initialRoute: '/', // 앱의 첫 화면
        observers: [
          _TabNavigatorObserver(onTabChanged: _updateCurrentTab),
        ],
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/': // 0: 홈 (지도)
              builder = (BuildContext context) => const MapMainScreen();
              break;
            case '/stats': // 1: 통계
              builder = (BuildContext context) =>
              const Center(child: Text('통계 화면'));
              break;
          // ---!!! [수정] '입출입' 탭(2번)이 Tagging_Main_Screen을 보여줌 !!!---
            case '/edit': // 2: 입출입 (태그 메인)
              builder = (BuildContext context) => const TaggingMainScreen();
              break;
            case '/community': // 3: 커뮤니티
              builder = (BuildContext context) =>
              const Center(child: Text('커뮤니티 화면'));
              break;
            case '/profile': // 4: 내 정보
              builder = (BuildContext context) =>
              const Center(child: Text('내 정보 화면'));
              break;

          // ---!!! [오류 수정] 'BuildContext:' -> 'BuildContext' !!!---
            case '/favorites': // 즐겨찾기 (별도 페이지)
              builder = (BuildContext context) => const FavoritesScreen();
              break;

          // ---!!! [오류 수정] 'BuildContext:' -> 'BuildContext' !!!---
            case '/search': // 검색 (별도 페이지)
              builder = (BuildContext context) => const SearchScreen();
              break;

          // ---!!! [신규] '태그 성공' 화면 라우트 추가 !!!---
            case '/tagging_success':
            // ---!!! [오류 수정] 'BuildContext:' -> 'BuildContext' !!!---
              builder = (BuildContext context) => const TaggingSuccessScreen();
              break;
            default:
              builder = (BuildContext context) => const MapMainScreen();
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),

      // ---!!! [핵심] 하단 탭 바 (이전과 동일) !!!---
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '통계'),
          // ---!!! [수정] 님의 피그마 시안 아이콘으로 변경 !!!---
          BottomNavigationBarItem(
              icon: Icon(Icons.location_pin), label: '입출입'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '커뮤니티'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onBottomNavItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// ---!!! [수정] 님의 'PascalCase' 파일 이름에 맞게 수정 !!!---
class _TabNavigatorObserver extends NavigatorObserver {
  final Function(String) onTabChanged;
  _TabNavigatorObserver({required this.onTabChanged});

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name != null) {
      onTabChanged(previousRoute!.settings.name!);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      onTabChanged(route.settings.name!);
    }
  }
}