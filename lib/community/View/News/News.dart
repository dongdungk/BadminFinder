// 커뮤니티 - 뉴스 - View ui
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),

          //상단 항목바
          SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('자유게시판', style: TextStyle(color: Colors.grey)),
                Text('대회', style: TextStyle(color: Colors.grey)),
                Text(
                  '뉴스',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Text('설문조사', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          const SizedBox(height: 8),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '🏸 배드민턴 뉴스',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.refresh, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  '최신 배드민턴 소식을 확인하세요',
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _newsCard(
                    tag: '선수 소식',
                    time: '2시간 전',
                    title: '안세영, 세계 랭킹 1위 수성 성공',
                    content:
                    '안세영 선수가 이번 주 세계배드민턴연맹(BWF) 랭킹에서 1위를 유지하며 강력한 행보를 이어가고 있습니다.\n'
                        '최근 대회에서의 압도적인 경기력으로 2위와의 격차를 더욱 벌려나가고 있습니다.',
                    source: '배드민턴 코리아',
                  ),
                  _newsCard(
                    tag: '대회 소식',
                    time: '5시간 전',
                    title: '2024 전국 대학 배드민턴 대회 개최',
                    content:
                    '다음 달 서울 올림픽공원 체조경기장에서 전국 대학 배드민턴 대회가 열립니다.\n'
                        '전국 50여개 대학에서 200여명의 선수가 참가할 예정이며, 남녀 단식, 복식, 혼합복식 종목이 진행됩니다.',
                    source: '스포츠 뉴스',
                  ),
                  _newsCard(
                    tag: '용품 리뷰',
                    time: '1일 전',
                    title: 'YONEX, 신제품 아스트록스 100 ZZ 공개',
                    content:
                    '오버헤드 최신 기술이 집약된 신제품 라켓을 공개했습니다.\n'
                        '새로운 제너레이터 시스템으로 스윙 속도와 파워가 대폭 향상되었습니다.',
                    source: '용품 리뷰',
                  ),
                  _newsCard(
                    tag: '국제 소식',
                    time: '1일 전',
                    title: '배드민턴, 올림픽 메달 전망 밝아',
                    content:
                    '2024 파리 올림픽을 앞두고 한국 배드민턴 대표팀의 메달 전망이 밝습니다.\n'
                        '여자 단식과 복식 종목에서 특히 강세를 보이고 있습니다.',
                    source: '올림픽 뉴스',
                  ),
                  _newsCard(
                    tag: '건강',
                    time: '2일 전',
                    title: '배드민턴 부상 예방을 위한 스트레칭',
                    content:
                    '경기 전후 필수 스트레칭 방법을 소개합니다.\n'
                        '어깨, 허벅지, 무릎 부상을 예방하기 위한 효율적인 루틴을 안내합니다.',
                    source: '헬스 케어',
                  ),
                  _newsCard(
                    tag: '동호회',
                    time: '2일 전',
                    title: '국내 배드민턴 동호회 회원 100만 돌파',
                    content:
                    '전국 배드민턴 동호회 회원 수가 100만명을 넘어서며 활발한 활동을 이어가고 있습니다.',
                    source: '생활 체육',
                  ),
                  _newsCard(
                    tag: '협회 소식',
                    time: '3일 전',
                    title: '주니어 선수 육성 프로그램 확대',
                    content:
                    '대한배드민턴협회가 주니어 선수 육성을 위한 프로그램을 새롭게 발표했습니다.',
                    source: '협회 공지',
                  ),
                  _newsCard(
                    tag: '시설',
                    time: '3일 전',
                    title: '배드민턴 코트 예약 시스템 개선',
                    content:
                    '전국 공공 체육관의 배드민턴 코트 예약이 더욱 편리해집니다.\n'
                        '새로운 통합 시스템이 도입되었습니다.',
                    source: '시설 안내',
                  ),
                  const SizedBox(height: 30),
                ],
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


  Widget _newsCard({
    required String tag,
    required String time,
    required String title,
    required String content,
    required String source,
  })
  {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 6),


          Text(
            title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 4),


          Text(
            content,
            style: const TextStyle(
                fontSize: 13, color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 6),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('출처: $source',
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const Text(
                '자세히 보기 >',
                style: TextStyle(fontSize: 12, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}