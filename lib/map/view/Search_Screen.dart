import 'package:flutter/material.dart';
// ---!!! import 경로를 님의 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Facility_Detail_Screen.dart';

class SearchScreen extends StatefulWidget {
  // ---!!! [핵심] 이 페이지는 자신만의 Scaffold를 가집니다 !!!---
  // (하단 탭 바는 부모인 Main_Screen이 가지고 있습니다)
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ---!!! [수정] 님이 요청하신 Mock 데이터로 전면 교체 !!!---
  final List<Map<String, dynamic>> searchResults = [
    {
      "name": "강남구민체육센터",
      "distance": "1.2km",
      "address": "서울 강남구 개포동 153",
      "hours": "09:00 - 18:00",
      "price": "3,000원/시간",
      "reservation": "예약 가능", // "예약 가능", "예약 불가", "문의 필요"
      "status": "운영중" // "운영중", "운영 종료", "휴무"
    },
    {
      "name": "서초 배드민턴장",
      "distance": "2.5km",
      "address": "서울 서초구 서초동 22",
      "hours": "06:00 - 22:00",
      "price": "5,000원/시간",
      "reservation": "예약 불가",
      "status": "운영중"
    },
    {
      "name": "마포구민체육센터",
      "distance": "4.8km",
      "address": "서울 마포구 성산동 533-1",
      "hours": "10:00 - 17:00",
      "price": "무료",
      "reservation": "문의 필요",
      "status": "휴무"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---!!! [수정] 하단 탭이 가려지는 문제 해결 !!!---
      resizeToAvoidBottomInset: false,

      // 1. 상단 앱 바 (AppBar)
      appBar: AppBar(
        // '뒤로가기' 버튼이 자동으로 생성됩니다.
        title: TextField(
          autofocus: true, // 자동으로 키보드 포커스
          decoration: InputDecoration(
            hintText: '시설 검색...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: InputBorder.none,
          ),
          onSubmitted: (String query) {
            // TODO: ViewModel을 통해 실제 검색 로직 수행
          },
        ),
        actions: [
          // ---!!! 2. 님이 요청하신 즐겨찾기(별) 버튼 !!!---
          IconButton(
            icon: const Icon(Icons.star_border, color: Colors.black),
            onPressed: () {
              // (하단 탭이 사라지지 않도록 중첩 네비게이터 안에서 이동)
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),

      // 2. 메인 컨텐츠
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---!!! 3. 님이 요청하신 '특정시설 검색 목록' 타이틀 !!!---
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              '특정시설 검색 목록',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // ---!!! [수정] 님이 요청하신 '정보' 리스트로 변경 !!!---
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final result = searchResults[index];
                // 새로운 헬퍼 함수 호출
                return _buildFacilityResultCard(context, result);
              },
            ),
          ),
        ],
      ),
      // ---!!! [핵심] 하단 탭 바는 이 파일에 없습니다 !!!---
      // (부모인 Main_Screen.dart가 가지고 있습니다)
    );
  }

  // ---!!! [신규] 님이 요청하신 상세 정보 카드 헬퍼 !!!---
  Widget _buildFacilityResultCard(
      BuildContext context, Map<String, dynamic> facility) {
    // 운영 상태에 따른 색상 결정
    Color statusColor;
    switch (facility['status']) {
      case '운영중':
        statusColor = Colors.green;
        break;
      case '휴무':
        statusColor = Colors.orange;
        break;
      default: // '운영 종료' 등
        statusColor = Colors.red;
    }

    // 예약 가능 상태에 따른 색상 결정
    Color reservationColor;
    switch (facility['reservation']) {
      case '예약 가능':
        reservationColor = Colors.blue;
        break;
      case '예약 불가':
        reservationColor = Colors.grey;
        break;
      default: // '문의 필요' 등
        reservationColor = Colors.purple;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          // ---!!! 프로토타입 연결 (C) !!!---
          // '시설 소개'는 하단 탭이 필요 없으므로 'rootNavigator: true'
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
                builder: (context) => const FacilityDetailScreen()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 이름 / 거리
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    facility['name'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    facility['distance'],
                    style: const TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // 2. 주소
              Text(
                facility['address'],
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 12),

              // 3. 운영시간 / 시간당 가격
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(facility['hours'], style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 12),
                  const Icon(Icons.payment, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(facility['price'], style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),

              // 4. 예약 가능 / 운영 상태 (칩)
              Row(
                children: [
                  Chip(
                    label: Text(facility['reservation']),
                    backgroundColor: reservationColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: reservationColor, fontSize: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(facility['status']),
                    backgroundColor: statusColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: statusColor, fontSize: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}