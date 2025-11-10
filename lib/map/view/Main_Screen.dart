import 'package:flutter/material.dart';
// ---!!! 4개의 import 경로를 님의 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Map_Main_Screen.dart';
import 'package:victor/map/view/Favorite_Screen.dart';
import 'package:victor/map/view/Search_Screen.dart';
// '입출입' 탭을 위한 임시 수정 화면 (Center로 대체)
// import 'package:victor/map/view/Edit_Screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 현재 선택된 탭 인덱스 (0번 '홈' 탭(지도)에서 시작)
  int _selectedIndex = 0;

  // 5개의 탭이 보여줄 '알맹이' 위젯 목록
  static const List<Widget> _widgetOptions = <Widget>[
    MapMainScreen(), // 0: 홈 (지도)
    Center(child: Text('통계 화면 (준비중)', style: TextStyle(fontSize: 20))), // 1: 통계
    Center(child: Text('수정 화면 (준비중)', style: TextStyle(fontSize: 20))), // 2: 입출입 (요청하신 '수정 화면')
    Center(child: Text('커뮤니티 화면 (준비중)', style: TextStyle(fontSize: 20))), // 3: 커뮤니티
    Center(child: Text('내 정보 화면 (준비중)', style: TextStyle(fontSize: 20))), // 4: 내 정보
  ];

  // 탭이 선택되었을 때 호출될 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ---!!! '홈'(지도) 탭일 때만 보여줄 AppBar !!!---
  AppBar _buildMapAppBar(BuildContext context) {
    return AppBar(
      // '뒤로가기' 버튼 없음
      title: GestureDetector(
        onTap: () {
          // ---!!! 프로토타입 연결 (A) !!!---
          // 검색창 텍스트필드를 탭하면 'SearchScreen'으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
        child: Container(
          color: Colors.transparent, // 탭 영역을 넓히기 위해
          child: TextField(
            enabled: false, // 탭 이벤트를 위해 비활성화
            decoration: InputDecoration(
              hintText: '검색창 : ',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey[400]),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.star_border, color: Colors.black),
          onPressed: () {
            // ---!!! 님의 새 요구사항 (지도 -> 즐겨찾기) !!!---
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            );
          },
        ),
      ],
    );
  }

  // ---!!! 다른 탭일 때 보여줄 기본 AppBar !!!---
  AppBar _buildDefaultAppBar(String title) {
    return AppBar(
      title: Text(title),
      // 다른 탭에서는 검색/즐겨찾기 버튼 없음
    );
  }

  @override
  Widget build(BuildContext context) {
    // 현재 선택된 탭에 따라 AppBar를 동적으로 결정
    final List<String> titles = ['홈', '통계', '입출입', '커뮤니티', '내 정보'];
    final AppBar currentAppBar = (_selectedIndex == 0)
        ? _buildMapAppBar(context) // 0번 탭(지도)일 때
        : _buildDefaultAppBar(titles[_selectedIndex]); // 나머지 탭일 때

    return Scaffold(
      appBar: currentAppBar,
      body: IndexedStack(
        // 탭이 전환되어도 각 화면의 상태를 유지
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '통계',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz), // '입출입' 아이콘
            label: '입출입',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '내 정보',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}