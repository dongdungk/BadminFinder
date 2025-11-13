//커뮤니티 - 자유게시판 - 글작성 view ui
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

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
          '글 작성',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '작성',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('아이콘 (선택)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.emoji_emotions_outlined,
                            color: Colors.black54),
                        SizedBox(width: 8),
                        Text('아이콘 선택',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('제목 *',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: '제목을 입력하세요',
                      hintStyle: const TextStyle(color: Colors.grey),
                      counterText: '0/50',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.black45, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('내용 *',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 8,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText:
                      '내용을 입력하세요\n\n'
                          '예시:\n'
                          '- 배드민턴 동호회 모집합니다\n'
                          '- 초보자도 환영합니다\n'
                          '- 매주 토요일 오전 10시',
                      hintStyle: const TextStyle(color: Colors.grey),
                      counterText: '0/500',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.black45, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline,
                          color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text('작성 팁',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '- 구체적이고 명확한 제목을 작성해주세요\n'
                        '- 욕설이나 비방은 삼가주세요\n'
                        '- 연락처 등 개인정보는 공개하지 마세요',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
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
}