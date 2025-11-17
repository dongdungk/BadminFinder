//커뮤니티 - 설문조사 - 투표결과 view ui
import 'package:flutter/material.dart';
import 'vote_result_bar.dart';


class SurveyResultPage extends StatelessWidget {
  const SurveyResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //상단 바
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          '투표 결과',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '배드민턴 브랜드 선호도',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),

            const Text(
              '총 127명 참여',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 28),

            const VoteResultBar(
              brand: 'YONEX',
              percent: 45,
              people: 57,
              color: Colors.blue,
            ),
            const SizedBox(height: 18),

            const VoteResultBar(
              brand: 'VICTOR',
              percent: 28,
              people: 36,
              color: Colors.green,
            ),
            const SizedBox(height: 18),

            const VoteResultBar(
              brand: 'LI-NING',
              percent: 18,
              people: 23,
              color: Colors.orange,
            ),
            const SizedBox(height: 18),

            const VoteResultBar(
              brand: '기타',
              percent: 9,
              people: 11,
              color: Colors.grey,
            ),

            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "홈",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoteResultBar extends StatelessWidget {
  final String brand;
  final int percent;
  final int people;
  final Color color;

  const VoteResultBar({
    super.key,
    required this.brand,
    required this.percent,
    required this.people,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              brand,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              '$percent% ($people명)',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percent / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}