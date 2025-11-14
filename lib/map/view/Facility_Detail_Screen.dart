import 'package:flutter/material.dart';
// ---!!! 2개의 import 경로를 님의 실제 파일명(대소문자)에 맞게 수정 !!!---
import 'package:victor/map/view/Facility_Photo_Screen.dart'; // 사진 화면 import
import 'package:victor/map/view/Facility_Review_screen.dart'; // 리뷰 화면 import (s 소문자 주의)

class FacilityDetailScreen extends StatefulWidget {
  const FacilityDetailScreen({super.key});

  @override
  State<FacilityDetailScreen> createState() => _FacilityDetailScreenState();
}

class _FacilityDetailScreenState extends State<FacilityDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // ---!!! [신규] 님이 요청하신 2개의 대표 이미지 !!!---
  final List<String> facilityImages = [
    'assets/badminton_img0302.jpg',
    'assets/cts5395_img07.jpg',
  ];

  @override
  void initState() {
    super.initState();
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
        title: const Text('시설 소개'), // 님의 피그마 시안 타이틀
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border), // 즐겨찾기 전
            onPressed: () {
              // TODO: 즐겨찾기 추가/삭제 로직
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // TODO: 공유하기 기능
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---!!! [수정] 님이 요청하신 2개 이미지 슬라이더/그리드 !!!---
            _buildImageSlider(),

            // 2. 탭 바 (정보, 리뷰, 사진)
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              tabs: [
                _buildTab('정보'),
                _buildTab('리뷰 (32)'), // (Mock 데이터 반영)
                _buildTab('사진 (2)'), // (Mock 데이터 반영)
              ],
              onTap: (index) {
                // ---!!! 프로토타입 연결 (D, E) !!!---
                if (index == 1) {
                  // (FacilityReviewScreen의 클래스명 확인 필요)
                  Navigator.push(
                    context,
                    // ---!!! [오류 2 수정] 'const' 키워드 제거 !!!---
                    MaterialPageRoute(
                        builder: (context) => FacilityReviewScreen()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FacilityPhotoScreen()),
                  );
                }
                _tabController.animateTo(0);
              },
            ),

            // 3. '정보' 탭 컨텐츠
            _buildInfoTabContent(),
          ],
        ),
      ),
    );
  }

  // ---!!! [신규] 대표 이미지 2개를 보여주는 위젯 ---!!!
  Widget _buildImageSlider() {
    return Container(
      height: 250,
      // (2개뿐이라 GridView로 2x1 꽉 채우게 만듭니다)
      child: GridView.builder(
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(), // 스크롤 방지
        itemCount: facilityImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 한 줄에 2개
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return Image.asset(
            facilityImages[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Icon(Icons.error_outline, color: Colors.grey),
              );
            },
          );
        },
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

  // ---!!! [수정] 님이 요청하신 '상세 정보' 탭 UI !!!---
  Widget _buildInfoTabContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '마포구민체육센터', // 시설 이름 (임시)
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text('4.51',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Text('(리뷰 32)',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // ---!!! 님이 요청하신 상세 정보 (피그마 시안 기반) !!!---
          _buildInfoRow(
            Icons.location_on_outlined,
            '주소',
            '서울 마포구 월드컵로25길 190',
            // 주소 복사 버튼 (선택적 기능)
            trailingWidget: TextButton(
              child: const Text('복사'),
              onPressed: () {
                // TODO: 주소 클립보드 복사 로직
              },
            ),
          ),
          _buildInfoRow(
            Icons.subway_outlined,
            '지하철',
            '마포구청역 1번 출구에서 597m',
          ),
          _buildInfoRow(
            Icons.access_time_outlined,
            '운영시간',
            '평일 06:00 - 23:00\n주말 09:00 - 18:00 (일요일 휴무)', // 상세 정보
          ),
          _buildInfoRow(
            Icons.call_outlined,
            '전화번호',
            '02-591-6060',
            // 전화걸기 버튼 (선택적 기능)
            trailingWidget: TextButton(
              child: const Text('전화'),
              onPressed: () {
                // TODO: 전화걸기 로직
              },
            ),
          ),
          _buildInfoRow(
            Icons.info_outline,
            '시설정보',
            '마포구 주민을 위한 다양한 스포츠 시설이 준비되어 있습니다. 배드민턴, 헬스, 수영 등...', // 상세 정보
          ),
          // ---!!! [수정 완료] ---!!!

          const SizedBox(height: 24),
          const Text(
            '시설 현황',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // (피그마 시안의 '혼잡도 현황 UI' 부분)
          Container(
            height: 100,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            // (실제 데이터가 없으므로 임시 텍스트로 표시)
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('현재 "보통"입니다.',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange)),
                SizedBox(height: 8),
                Text('약 37명 (50명 정원)',
                    style: TextStyle(fontSize: 15, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---!!! [수정] 상세 정보 Row 헬퍼 (trailingWidget 추가) !!!---
  Widget _buildInfoRow(IconData icon, String title, String content,
      {Widget? trailingWidget}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600], size: 22),
          const SizedBox(width: 16),
          // 제목 (고정 너비)
          SizedBox(
            width: 80, // '운영시간' 등이 2줄이 되지 않게
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
          ),
          const SizedBox(width: 16),
          // 내용
          Expanded(
            child: Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // 맨 오른쪽 위젯 (예: '복사' 버튼)
          if (trailingWidget != null) trailingWidget,
        ],
      ),
    );
  }
}