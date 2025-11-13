// 커뮤니티 - 뉴스 - 자세히 보기 View ui
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        title: const Text(
          '배드민턴 뉴스',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '선수 소식',
                style: TextStyle(
                    color: Color(0xFF388E3C),
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ),
            const SizedBox(height: 10),


            const Text(
              '안세영, 세계 랭킹 1위 수성 성공',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 6),


            const Text(
              '2시간 전',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),


            const Text(
              '안세영 선수가 이번 주 세계배드민턴연맹(BWF) 랭킹에서 1위를 유지하며 강력한 행보를 이어가고 있습니다.\n\n'
                  '최근 대회에서 보여준 압도적인 경기력으로 2위와의 격차를 더욱 벌려나가고 있습니다. 특히 지난 주말 열린 국제대회에서 결승전까지 한 세트도 내주지 않는 완벽한 경기를 펼쳤습니다.\n\n'
                  '안세영 선수는 경기 후 인터뷰에서 “앞으로도 최선을 다해 항상 1위를 지키겠다”고 겸손한 소감을 밝혔습니다. 전문가들은 그녀의 빠른 스피드와 정확한 샷 능력이 세계 최고 수준이라고 평가하고 있습니다.\n\n'
                  '대한배드민턴협회는 안세영 선수의 훈련과 대회 참가를 적극 지원하고 있으며, 2024 파리 올림픽 금메달 획득을 목표로 체계적인 관리를 하고 있습니다.',
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),


            const Text(
              '출처: 배드민턴 코리아',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 4),

            const Text(
              '저작권 © 2025 배드민턴 코리아. All rights reserved.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 24),


            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, color: Colors.grey),
                  SizedBox(width: 6),
                  Text('추천 42',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 30),


            const Text(
              '댓글 2',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Container(
              height: 100,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '댓글을 입력하세요...',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 10),

            // 댓글 작성 버튼
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF2E7D32),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '댓글 작성',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}