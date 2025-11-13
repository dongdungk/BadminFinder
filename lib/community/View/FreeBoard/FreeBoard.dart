//커뮤니티 - 자유게시판 view ui
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.deepPurpleAccent.shade100;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),

          //상단 항목바
          Container(
            height: 48,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  '자유게시판',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Text('대회', style: TextStyle(color: Colors.grey)),
                Text('뉴스', style: TextStyle(color: Colors.grey)),
                Text('설문조사', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  _buildPostItem(
                    icon: '🔍',
                    title: '오늘 저녁 7시 배드민턴 치실 분!',
                    content: '체육관에서 복식으로 게임하실 분 구합니다',
                    time: '15분 전',
                    views: 81,
                    likes: 3,
                  ),
                  _buildPostItem(
                    icon: '🏸',
                    title: '배드민턴 동호회 정기 모임 안내',
                    content: '이번 주 토요일 오전 10시 체육관에서 모임 있습니다!',
                    time: '15분 전',
                    views: 61,
                    likes: 4,
                  ),
                  _buildPostItem(
                    icon: '🏸',
                    title: '라켓 추천 부탁드려요',
                    content: '초보자인데 어떤 라켓 사는 게 좋을까요?',
                    time: '20분 전',
                    views: 54,
                    likes: 2,
                  ),
                  _buildPostItem(
                    icon: '💪',
                    title: '스매시 잘 치는 법 알려주세요',
                    content: '스매시를 쳐도 힘이 없고 각도가 안 나와요 ㅠㅠ',
                    time: '30분 전',
                    views: 109,
                    likes: 6,
                  ),
                  _buildPostItem(
                    icon: '🏆',
                    title: '배드민턴 대회 출전 모집!!',
                    content: '다음 달 대학 리그전 나갈 분들 모집합니다!\n1등 상금 50만원, 2등 30만원입니다',
                    time: '30분 전',
                    views: 119,
                    likes: 8,
                  ),
                  _buildPostItem(
                    icon: '🏸',
                    title: '서브 넣을 때 자꾸 네트에 걸려요',
                    content: '롱 서브 연습하는데 계속 네트에 걸리네요.\n혹시 팁 있으신 분 계신가요?',
                    time: '10/31',
                    views: 92,
                    likes: 3,
                  ),
                  _buildPostItem(
                    icon: '⭐',
                    title: '백핸드 클리어 드디어 성공!',
                    content: '3개월 연습한 보람이 있네요 ㅋㅋ',
                    time: '1시간 전',
                    views: 98,
                    likes: 9,
                  ),
                  _buildPostItem(
                    icon: '🏟️',
                    title: '체육관 예약 어떻게 하나요?',
                    content: '학교 체육관 배드민턴 코트 예약 방법 아시는 분?',
                    time: '1시간 전',
                    views: 118,
                    likes: 8,
                  ),
                  _buildPostItem(
                    icon: '🏸',
                    title: '셔틀콕 추천해주세요',
                    content: '어떤 셔틀콕이 내구성 좋나요?',
                    time: '1시간 전',
                    views: 94,
                    likes: 6,
                  ),
                  _buildPostItem(
                    icon: '💪',
                    title: '배드민턴 체력 훈련 루틴',
                    content: '배드민턴 잘 치려면 어떤 운동을 해야 할까요?',
                    time: '2시간 전',
                    views: 108,
                    likes: 10,
                  ),
                  _buildPostItem(
                    icon: '😆',
                    title: '오늘 복식 게임 개꿀잼ㅋㅋ',
                    content: '오랜만에 땀 흘리며 운동하니까 너무 좋네요',
                    time: '2시간 전',
                    views: 118,
                    likes: 8,
                  ),
                  _buildPostItem(
                    icon: '🎥',
                    title: '배드민턴 기술 영상 공유',
                    content: '유튜브에서 좋은 강의 영상 찾았어요!',
                    time: '2시간 전',
                    views: 91,
                    likes: 4,
                  ),
                  _buildPostItem(
                    icon: '😢',
                    title: '라켓 줄 끊어졌어요 ㅠㅠ',
                    content: '스트링 재작업 어디서 하면 좋을까요?',
                    time: '3시간 전',
                    views: 95,
                    likes: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: themeColor,
        child: const Icon(Icons.edit, color: Colors.white),
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

  Widget _buildPostItem({
    required String icon,
    required String title,
    required String content,
    required String time,
    required int views,
    required int likes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // 내용
          Text(
            content,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(width: 8),
              const Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 3),
              Text('$views', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(width: 8),
              const Icon(Icons.thumb_up_alt_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 3),
              Text('$likes', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
