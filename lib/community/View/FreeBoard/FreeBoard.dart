// 커뮤니티 - 자유게시판 - view ui

import 'package:flutter/material.dart';

class CommunityBoardPage extends StatefulWidget {
  const CommunityBoardPage({super.key});

  @override
  State<CommunityBoardPage> createState() => _CommunityBoardPageState();
}

class _CommunityBoardPageState extends State<CommunityBoardPage> {
  int selectedTabIndex = 0; // 0: 자유게시판, 1: 대회, 2: 뉴스, 3: 설문조사
  final List<String> tabTitles = ['자유게시판', '대회', '뉴스', '설문조사'];

  // 게시물 데이터 예시
  final List<Map<String, dynamic>> posts = [
    {
      "icon": "🏸",
      "title": "오늘 저녁 7시 배드민턴 치실 분!",
      "content": "체육관에서 복식으로 게임하실 분 구합니다",
      "time": "15분 전",
      "views": 83,
      "likes": 3,
      "comments": 0
    },
    {
      "icon": "🔥",
      "title": "배드민턴 동호회 정기 모임 안내",
      "content": "이번 주 토요일 오전 10시 체육관에서 모임 있습니다!",
      "time": "15분 전",
      "views": 61,
      "likes": 8,
      "comments": 0
    },
    {
      "icon": "🏸",
      "title": "라켓 추천 부탁드려요",
      "content": "초보자인데 어떤 라켓 사는 게 좋을까요?",
      "time": "20분 전",
      "views": 89,
      "likes": 5,
      "comments": 0
    },
    {
      "icon": "💪",
      "title": "스매시 잘 치는 법 알려주세요",
      "content": "스매시를 쳐도 힘이 없고 각도가 안 나와요 ㅠㅠ",
      "time": "30분 전",
      "views": 109,
      "likes": 6,
      "comments": 0
    },
    {
      "icon": "🏆",
      "title": "배드민턴 대회 출전 모집!!",
      "content": "다음 달 대학 리그전 나갈 분들 모집합니다!",
      "time": "30분 전",
      "views": 149,
      "likes": 19,
      "comments": 0
    },
    {
      "icon": "🎯",
      "title": "서브 정확도 올리는 꿀팁 공유합니다",
      "content": "팔 각도를 조금만 조정하니까 서브가 훨씬 안정적이에요!",
      "time": "40분 전",
      "views": 52,
      "likes": 7,
      "comments": 2
    },
    {
      "icon": "🧢",
      "title": "오늘 새 라켓 샀어요!",
      "content": "요넥스 나노플레어 너무 가볍고 좋네요 ㅎㅎ",
      "time": "50분 전",
      "views": 68,
      "likes": 9,
      "comments": 1
    },
    {
      "icon": "💬",
      "title": "혹시 배드민턴 동호회 추천해주실 분?",
      "content": "서울 강남 쪽 활동적인 모임 있으면 알려주세요!",
      "time": "1시간 전",
      "views": 75,
      "likes": 5,
      "comments": 4
    },
    {
      "icon": "🎥",
      "title": "발리 영상 보고 자세 분석해주세요!",
      "content": "폼이 좀 이상한데 뭐가 문제인지 모르겠어요ㅠ",
      "time": "1시간 전",
      "views": 91,
      "likes": 6,
      "comments": 5
    },
    {
      "icon": "🏆",
      "title": "다음 주 교내 대회 나가시는 분?",
      "content": "복식 파트너 구합니다! 연습은 평일 저녁 가능합니다!",
      "time": "1시간 전",
      "views": 88,
      "likes": 10,
      "comments": 3
    },
    {
      "icon": "🧤",
      "title": "겨울철 라켓 그립 관리법 아시는 분?",
      "content": "요즘 손에 땀이 덜 나서 미끄러워요ㅠ 팁 좀 주세요!",
      "time": "2시간 전",
      "views": 40,
      "likes": 3,
      "comments": 1
    },
    {
      "icon": "📸",
      "title": "어제 경기 사진 올려요!",
      "content": "모두 즐겁게 쳤어요~ 다음에도 또 모여요!",
      "time": "2시간 전",
      "views": 100,
      "likes": 12,
      "comments": 4
    },
    {
      "icon": "⏰",
      "title": "아침 운동 같이 하실 분~",
      "content": "출근 전 7시쯤 배드민턴 한 시간 하고 싶어요!",
      "time": "2시간 전",
      "views": 59,
      "likes": 4,
      "comments": 0
    },
    {
      "icon": "🩹",
      "title": "손목 통증 있으신 분 계신가요?",
      "content": "요즘 스윙 후에 손목이 뻐근해서 고민이에요",
      "time": "3시간 전",
      "views": 77,
      "likes": 2,
      "comments": 3
    },
    {
      "icon": "🍀",
      "title": "오늘 경기에서 첫 승 했어요!!",
      "content": "드디어 서브가 안정적으로 들어가네요 😊",
      "time": "3시간 전",
      "views": 82,
      "likes": 11,
      "comments": 5
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30), // 상태바 아래 간격

          // 상단 탭바
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabTitles.length, (index) {
                final isSelected = selectedTabIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tabTitles[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.black : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (isSelected)
                        Container(
                          width: 24,
                          height: 2,
                          color: Colors.black,
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 8),

          // 게시물 리스트
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return _PostCard(post: post);
              },
            ),
          ),
        ],
      ),

      // 글 작성 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.edit, color: Colors.white),
      ),

      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
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

// ✅ 실제 게시물 카드 UI
class _PostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.deepPurpleAccent.withOpacity(0.4),
          width: 1.3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post["icon"], style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  post["title"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // 내용
          Text(
            post["content"],
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),

          const SizedBox(height: 8),

          // 하단 정보
          Row(
            children: [
              Text(post["time"], style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              const SizedBox(width: 6),
              const Icon(Icons.person_outline, size: 14, color: Colors.grey),
              const SizedBox(width: 2),
              const Text('익명', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(width: 6),
              const Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 2),
              Text('${post["views"]}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(width: 6),
              const Icon(Icons.thumb_up_alt_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 2),
              Text('${post["likes"]}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
