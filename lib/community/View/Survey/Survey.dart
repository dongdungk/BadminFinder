// 커뮤니티 - 설문조사 - view ui

import 'package:flutter/material.dart';

class CommunityBoardPage extends StatefulWidget {
  const CommunityBoardPage({super.key});

  @override
  State<CommunityBoardPage> createState() => _CommunityBoardPageState();
}

class _CommunityBoardPageState extends State<CommunityBoardPage> {
  int selectedTabIndex = 3; // 0: 자유게시판, 1: 대회, 2: 뉴스, 3: 설문조사
  final List<String> tabTitles = ['자유게시판', '대회', '뉴스', '설문조사'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30), // 상태바 아래 간격

          // 상단 탭바
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabTitles.length, (index) {
                final isSelected = selectedTabIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tabTitles[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.black : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (isSelected)
                        Container(
                          width: 24,
                          height: 2,
                          color: Colors.black,
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),


      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: '통계'),
          BottomNavigationBarItem(icon: Icon(Icons.group_add_outlined), label: '입출입'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '커뮤니티'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '내 정보'),
        ],
      ),
    );
  }
}
