//커뮤니티 - 설문조사 - 투표완료 view ui
import 'package:flutter/material.dart';

class SurveyCompletePage extends StatelessWidget {
  const SurveyCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 4),
              ),
              child: const Icon(Icons.check, size: 60, color: Colors.green),
            ),
            const SizedBox(height: 24),
            const Text(
              "투표 완료!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("의견 감사합니다.", style: TextStyle(fontSize: 15, color: Colors.black54)),
            const SizedBox(height: 12),
            const Text("128명 참여", style: TextStyle(fontSize: 14, color: Colors.black38)),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 6),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "결과 보기",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 6),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "확인",
                    style: TextStyle(color: Colors.black87, fontSize: 15),
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