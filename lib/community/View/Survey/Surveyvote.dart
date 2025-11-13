//커뮤니티 - 설문조사 - 투표 중 view ui
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //상단 바
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          '배드민턴 브랜드 투표',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "가장 선호하는 배드민턴 라켓 브랜드는?",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 20),

          //선택1
          _buildOptionItem(
            color: Colors.blue,
            label: "YONEX 요넥스",
          ),

          //선택2
          _buildOptionItem(
            color: Colors.orange,
            label: "VICTOR 빅터",
          ),

          //선택3
          _buildOptionItem(
            color: Colors.redAccent,
            label: "LI-NING 리닝",
          ),

          //선택4
          _buildOptionItem(
            color: Colors.grey,
            label: "기타",
          ),

          const Spacer(),

          //투표
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "투표하기",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),

      //하단 탭바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
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

  Widget _buildOptionItem({required Color color, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}