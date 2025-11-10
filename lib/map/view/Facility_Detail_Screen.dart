import 'package:flutter/material.dart';
// ---!!! 2개의 import 경로를 님의 실제 파일명(대소문자)에 맞게 수정 !!!---
import 'package:victor/map/view/Facility_Photo_Screen.dart'; // 사진 화면 import
import 'package:victor/map/view/Facility_Review_screen.dart'; // 리뷰 화면 import (s 소문자 주의)

class FacilityDetailScreen extends StatefulWidget {
  const FacilityDetailScreen({super.key});

  @override
  State<FacilityDetailScreen> createState() => _FacilityDetailScreenState();
}

// (중요) TabBar를 사용하려면 'TickerProviderStateMixin'이 필요합니다.
class _FacilityDetailScreenState extends State<FacilityDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 탭 컨트롤러 초기화 (총 3개 탭)
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // '뒤로가기' 버튼 자동 생성
        title: const Text('서초구 시설'), // 임시 타이틀
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border), // 즐겨찾기 전
            // icon: const Icon(Icons.star, color: Colors.amber), // 즐겨찾기 후
            onPressed: () {
              // TODO: 즐겨찾기 추가/삭제 로직
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. 시설 대표 이미지 (임시)
            Container(
              height: 250,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Text('시설 대표 이미지', style: TextStyle(color: Colors.black54)),
            ),

            // 2. 탭 바 (정보, 리뷰, 사진)
            TabBar(
              controller: _tabController,
              labelColor: Colors.black, // 선택된 탭 텍스트 색상
              unselectedLabelColor: Colors.grey, // 선택 안된 탭 텍스트 색상
              indicatorColor: Colors.black, // 탭 하단 인디케이터 색상
              tabs: [
                _buildTab('정보'),
                _buildTab('리뷰 (0)'),
                _buildTab('사진 (0)'),
              ],
              onTap: (index) {
                // ---!!! 프로토타입 연결 (D, E) !!!---
                // 탭을 '클릭'하는 순간 별도 페이지로 이동시킵니다.
                if (index == 1) { // '리뷰' 탭 클릭
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FacilityReviewScreen()),
                  );
                } else if (index == 2) { // '사진' 탭 클릭
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FacilityPhotoScreen()),
                  );
                }
                // '정보' 탭(index 0)은 현재 페이지이므로 아무것도 안 함

                // (참고) 탭 이동 후, 다시 이 화면으로 돌아왔을 때
                // '정보' 탭이 선택되도록 인덱스를 0으로 리셋합니다.
                _tabController.animateTo(0);
              },
            ),

            // 3. '정보' 탭 컨텐츠
            // (참고: TabBarView를 사용하지 않고, 이 화면 자체를 '정보' 탭으로 사용)
            _buildInfoTabContent(),
          ],
        ),
      ),
    );
  }

  // 탭 위젯 (프로토타입의 UI와 유사하게)
  Widget _buildTab(String title) {
    return Tab(
      child: Container(
        height: 50, // 탭 높이 고정
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // '정보' 탭에 표시될 위젯
  Widget _buildInfoTabContent() {
    // 프로토타입의 'Map - 시설소...' 화면의 스크롤 내용
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '서초구 시설', // 시설 이름
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text('4.51', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Text('(리뷰 32)', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          _buildInfoRow(Icons.location_on_outlined, '주소', '서울 서초구...'),
          _buildInfoRow(Icons.call_outlined, '전화번호', '02-123-4567'),
          _buildInfoRow(Icons.access_time_outlined, '운영시간', '09:00 - 18:00'),
          _buildInfoRow(Icons.info_outline, '시설정보', '설명...'),

          const SizedBox(height: 24),
          const Text(
            '시설 현황',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // TODO: 시설 현황 그래프 또는 슬라이더 UI (프로토타입의 혼잡도 바)
          Container(
            height: 100,
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: const Text('혼잡도 현황 UI (슬라이더 등)'),
          ),
        ],
      ),
    );
  }

  // 정보 행(Row)을 만드는 헬퍼 위젯
  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600], size: 22),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}