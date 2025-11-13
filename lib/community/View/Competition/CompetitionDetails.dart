//커뮤니티 - 대회 - 상세정보 view ui
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: Colors.white,

      //상단 바
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          '대회 상세정보',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 대표 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://img.olympics.com/images/image/private/ar_16:9,c_fill/f_auto/v1738322325/primary/kzteis81doqu9mskjfzq',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '사설',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),

            const SizedBox(height: 10),

            //대회 제목
            const Text(
              '부산 배드민턴 동호회 챌린지',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 4),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '접수중',
                style: TextStyle(color: themeColor, fontSize: 13),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              '부산 지역 배드민턴 동호인들의 실력 향상과 교류를 위한 챌린지 대회입니다.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 20),

            _buildInfoItem(
              icon: Icons.location_on_outlined,
              title: '개최 장소',
              content: '부산 실내체육관\n부산광역시 해운대구 해운대로 567',
            ),
            _buildInfoItem(
              icon: Icons.calendar_month_outlined,
              title: '대회 일정',
              content: '2025-11-18\n13:00 ~ 17:00',
            ),
            _buildInfoItem(
              icon: Icons.people_outline,
              title: '참가 자격',
              content: '부산/경남 지역 배드민턴 동호인',
            ),
            _buildInfoItem(
              icon: Icons.sports_tennis_outlined,
              title: '경기 종목',
              content: '혼합복식',
            ),
            _buildInfoItem(
              icon: Icons.attach_money_outlined,
              title: '참가비',
              content: '현장 납부',
            ),
            _buildInfoItem(
              icon: Icons.event_busy_outlined,
              title: '신청 마감',
              content: '별도 공지',
            ),
            _buildInfoItem(
              icon: Icons.description_outlined,
              title: '대회 규칙',
              content: '• 경기는 3게임 2선승제로 진행됩니다.\n'
                  '• 21점 랠리포인트 방식으로 진행됩니다.\n'
                  '• 참가비는 당일 현장 접수 시 납부합니다.',
            ),
            _buildInfoItem(
              icon: Icons.assignment_outlined,
              title: '주최/주관',
              content: '부산시 배드민턴 협회',
            ),
            _buildInfoItem(
              icon: Icons.phone_outlined,
              title: '문의',
              content: '010-1234-5678',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      //하단 탭바
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: themeColor,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {},
          child: const Text(
            '신청하기',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  content,
                  style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}