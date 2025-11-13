//커뮤니티 - 자유게시판 - 댓글 view ui
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.deepPurpleAccent.shade100; // 메인 컬러

    return Scaffold(
      backgroundColor: Colors.white,

      //상단 바
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          '자유게시판',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: themeColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text('🏸 ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(
                        '오늘 저녁 7시 배드민턴 치실 분!',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    '체육관에서 복식으로 게임하실 분 구합니다',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    '15분 전 | 익명',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: const [
                      Icon(Icons.thumb_up_alt_outlined,
                          color: Colors.grey, size: 18),
                      SizedBox(width: 4),
                      Text('0'),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline,
                          color: Colors.grey, size: 18),
                      SizedBox(width: 4),
                      Text('3'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: const Text(
                '댓글 3개',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: themeColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCommentItem(
                    nickname: '배드민턴매니아',
                    time: '10분 전',
                    comment: '저도 참여하고 싶어요! 초보도 괜찮을까요?',
                    likes: 3,
                  ),
                  const Divider(height: 24, color: Colors.grey, thickness: 0.3),

                  _buildCommentItem(
                    nickname: '스매시왕',
                    time: '25분 전',
                    comment: '좋은 정보 감사합니다!',
                    likes: 5,
                  ),
                  const Divider(height: 24, color: Colors.grey, thickness: 0.3),

                  _buildCommentItem(
                    nickname: '익명',
                    time: '1시간 전',
                    comment: '저도 같이 가고 싶네요 ㅎㅎ',
                    likes: 2,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '댓글을 입력하세요...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: themeColor,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.send, size: 20, color: Colors.white),
                ),
              ],
            ),
          ),

          //하단 탭바
          BottomNavigationBar(
            currentIndex: 3,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: '통계'),
              BottomNavigationBarItem(icon: Icon(Icons.group_add_outlined), label: '입출입'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '커뮤니티'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '내 정보'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem({
    required String nickname,
    required String time,
    required String comment,
    required int likes,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nickname,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(comment, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text('공감 $likes',
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}