//커뮤니티 - 설문조사 - view ui
import 'package:flutter/material.dart';
import 'package:seokju/community/view/community_top_tabs.dart';

class SurveyPage extends StatelessWidget {
  const SurveyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),

          //상단 탭바
          const CommunityTopTabs(),
          const SizedBox(height: 8),

          //설문조사 목록
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //설문 1
                  _SurveyCard(
                    title: '좋아하는 배드민턴 브랜드 투표',
                    participants: 127,
                    daysLeft: 5,
                    isCompleted: false,
                  ),
                  const SizedBox(height: 12),

                  //설문 2
                  _SurveyCard(
                    title: '우리 지역 체육관 만족도 조사',
                    participants: 89,
                    daysLeft: 12,
                    isCompleted: false,
                  ),
                  const SizedBox(height: 40),

                  const Text(
                    '완료된 설문',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 12),

                  //완료 설문
                  _SurveyCard(
                    title: '2024 배드민턴 선호도 조사',
                    participants: 0,
                    daysLeft: 0,
                    isCompleted: true,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SurveyCard extends StatelessWidget {
  final String title;
  final int participants;
  final int daysLeft;
  final bool isCompleted;

  const _SurveyCard({
    required this.title,
    required this.participants,
    required this.daysLeft,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green.shade100),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
                SizedBox(width: 6),
                Text('완료된 설문',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 36,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '결과 보기',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade100),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Row(
              children: [
                const Icon(Icons.poll_outlined, color: Colors.blue, size: 20),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.people_outline,
                    color: Colors.grey, size: 16),
                const SizedBox(width: 4),
                Text('$participants명 참여',
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const Spacer(),
                Text('D-$daysLeft',
                  style: const TextStyle(
                      color: Colors.blue
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            //참여 버튼
            SizedBox(
              width: double.infinity,
              height: 38,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('참여하기',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
          ],
        ),
      );
    }
  }
}