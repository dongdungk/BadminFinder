// 커뮤니티 - 대회 - view ui

import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int selectedTabIndex = 1;
  final List<String> tabTitles = ['자유게시판', '대회', '뉴스', '설문조사'];

  final List<Map<String, dynamic>> nationalCompetitions = [
    {
      "title": "제4회 올리버 배드민턴대회",
      "place": "(손내 사회체육관)",
      "status": "[경기준비]",
      "date": "2025-12-27",
      "likes": 2,
      "image": "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
    {
      "title": "2025 쓰렉스컵 전국 배드민턴대회",
      "place": "(미곡 실내체육관)",
      "status": "[경기준비]",
      "date": "2025-12-21",
      "likes": 5,
      "image": "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
    {
      "title": "제2회 스펙트럼 전국 배드민턴 챔피언쉽",
      "place": "(안산시 와동 배드민턴장)",
      "status": "[경기준비]",
      "date": "2025-12-20~2025-12-21",
      "likes": 0,
      "image": "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
  ];

  final List<Map<String, dynamic>> privateCompetitions = [
    {
      "title": "서울시 배드민턴 클럽 대회",
      "place": "(강남 체육센터)",
      "status": "[접수중]",
      "date": "2025-11-15",
      "likes": 12,
      "image": "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
    {
      "title": "부산 배드민턴 동호회 챌린지",
      "place": "(부산 실내체육관)",
      "status": "[접수중]",
      "date": "2025-11-18",
      "likes": 8,
      "image": "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
    {
      "title": "대구 배드민턴 오픈 대회",
      "place": "(대구 스포츠센터)",
      "status": "[경기준비]",
      "date": "2025-11-20~2025-11-21",
      "likes": 15,
      "image": "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          // 상단 탭바
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabTitles.length, (index) {
                final isSelected = selectedTabIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => selectedTabIndex = index),
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
                        Container(width: 24, height: 2, color: Colors.black),
                    ],
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 10),

          // 🔍 검색창
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '대회 이름으로 검색',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 🏆 리스트
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SectionTitle(title: '전국대회', color: Colors.blue),
                const SizedBox(height: 8),
                ...nationalCompetitions.map((item) => CompetitionCard(item)),

                const SizedBox(height: 20),

                const SectionTitle(title: '사설대회', color: Colors.blue),
                const SizedBox(height: 8),
                ...privateCompetitions.map((item) => CompetitionCard(item)),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),

      // 하단 네비게이션
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
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

class SectionTitle extends StatelessWidget {
  final String title;
  final Color color;
  const SectionTitle({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}

class CompetitionCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const CompetitionCard(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // 왼쪽 텍스트
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2)),
                const SizedBox(height: 6),
                Text(
                  data["title"],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  data["place"],
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  "${data["status"]} ${data["date"]}",
                  style: const TextStyle(color: Colors.indigo),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.thumb_up_alt_outlined,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("${data["likes"]}",
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          // 오른쪽 이미지
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              data["image"],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
