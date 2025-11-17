// community/view/competition/competition_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seokju/community/view/community_top_tabs.dart';

class CompetitionPage extends StatelessWidget {
  const CompetitionPage({super.key});

  final List<Map<String, dynamic>> nationalCompetitions = const [
    {
      "id": "n1",
      "title": "제4회 올리버 배드민턴대회",
      "place": "(손내 사회체육관)",
      "status": "[경기준비]",
      "date": "2025-12-27",
      "likes": 2,
      "image":
      "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
    {
      "id": "n2",
      "title": "2025 쓰렉스컵 전국 배드민턴대회",
      "place": "(미곡 실내체육관)",
      "status": "[경기준비]",
      "date": "2025-12-21",
      "likes": 5,
      "image":
      "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
    {
      "id": "n3",
      "title": "제2회 스펙트럼 전국 배드민턴 챔피언쉽",
      "place": "(안산시 와동 배드민턴장)",
      "status": "[경기준비]",
      "date": "2025-12-20~2025-12-21",
      "likes": 0,
      "image":
      "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
  ];

  final List<Map<String, dynamic>> privateCompetitions = const [
    {
      "id": "p1",
      "title": "서울시 배드민턴 클럽 대회",
      "place": "(강남 체육센터)",
      "status": "[접수중]",
      "date": "2025-11-15",
      "likes": 12,
      "image":
      "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
    {
      "id": "p2",
      "title": "부산 배드민턴 동호회 챌린지", // ← 이 항목만 상세 페이지로 이동
      "place": "(부산 실내체육관)",
      "status": "[접수중]",
      "date": "2025-11-18",
      "likes": 8,
      "image":
      "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
    {
      "id": "p3",
      "title": "대구 배드민턴 오픈 대회",
      "place": "(대구 스포츠센터)",
      "status": "[경기준비]",
      "date": "2025-11-20~2025-11-21",
      "likes": 15,
      "image":
      "https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),

          // 상단 탭바
          const CommunityTopTabs(),
          const SizedBox(height: 8),

          // 검색창
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "대회 이름으로 검색",
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("전국대회", Colors.blue),
                  const SizedBox(height: 8),
                  ...nationalCompetitions.map((e) => _buildCompetitionItem(
                    context: context,
                    data: e,
                    goDetail: false,
                  )),

                  const SizedBox(height: 20),

                  _buildSectionTitle("사설대회", Colors.blue),
                  const SizedBox(height: 8),
                  ...privateCompetitions.map((e) => _buildCompetitionItem(
                    context: context,
                    data: e,
                    goDetail: (e["id"] == "p2"), // ← 부산 챌린지만 이동 가능
                  )),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 구분 타이틀
  Widget _buildSectionTitle(String title, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 대회 항목 UI
  Widget _buildCompetitionItem({
    required BuildContext context,
    required Map<String, dynamic> data,
    required bool goDetail,
  }) {
    return GestureDetector(
      onTap: () {
        if (goDetail) {
          context.push("/community/competition/details");
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 텍스트 부분
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["title"],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(data["place"],
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text("${data["status"]} ${data["date"]}",
                      style: const TextStyle(color: Colors.indigo)),
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

            // 이미지
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
      ),
    );
  }
}
