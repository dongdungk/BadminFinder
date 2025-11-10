import 'package:flutter/material.dart';
// ---!!! import 경로를 님의 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Facility_Detail_Screen.dart'; // 시설 소개창 import

class FavoritesScreen extends StatefulWidget {
  // 'push'로 띄울 별도 화면이므로, 자신만의 Scaffold를 가집니다.
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // (프로토타입처럼 보이도록 Mock 데이터 다시 추가)
  final List<Map<String, dynamic>> favoriteList = [
    {
      "name": "강남구민체육센터",
      "distance": "1.2km",
      "rating": 4.7,
      "congestion": 10.0,
      "maxCapacity": 100.0
    },
    {
      "name": "잠실종합운동장 배드민턴장",
      "distance": "2.0km",
      "rating": 4.8,
      "congestion": 23.0,
      "maxCapacity": 100.0
    },
    {
      "name": "마포구민체육센터",
      "distance": "1.5km",
      "rating": 4.51,
      "congestion": 37.0,
      "maxCapacity": 100.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    // ---!!! 탭 뼈대(MainScreen)와 분리된 자신만의 Scaffold !!!---
    return Scaffold(
      // 1. 상단 앱 바 (AppBar)
      appBar: AppBar(
        // Navigator.push로 띄워졌기에 '뒤로가기(<)' 버튼이 자동으로 생깁니다.
        title: TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: '검색창 : ',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.grey[400]),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.star, color: Colors.amber), // 꽉 찬 별
          ),
        ],
      ),

      // 2. 메인 컨텐츠 (즐겨찾기 목록)
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              '즐겨찾기 목록',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: favoriteList.isEmpty
                ? const Center(
              child: Text(
                '즐겨찾기한 시설이 없습니다.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final item = favoriteList[index];
                // ---!!! State 클래스 내부의 메서드 호출 !!!---
                return InkWell(
                  onTap: () {
                    // ---!!! 프로토타입 연결 (C) !!!---
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FacilityDetailScreen()),
                    );
                  },
                  child: _buildFavoriteCard(
                    // context는 이제 메서드 내부에서 접근 가능
                    name: item['name'],
                    distance: item['distance'],
                    rating: item['rating'],
                    congestion: item['congestion'],
                    maxCapacity: item['maxCapacity'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---!!! 헬퍼 함수들을 State 클래스 *안*으로 이동 !!!---

  // 즐겨찾기 카드 위젯
  Widget _buildFavoriteCard({
    required String name,
    required String distance,
    required double rating,
    required double congestion,
    required double maxCapacity,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  distance,
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildStarRating(rating),
                const SizedBox(width: 8),
                Text(rating.toString(), style: const TextStyle(fontSize: 15)),
                const SizedBox(width: 16),
                Chip(
                  label: Text('${congestion.toInt()}명'),
                  backgroundColor: Colors.blue.shade100,
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  labelStyle: const TextStyle(fontSize: 13),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            const SizedBox(height: 12),
            SliderTheme(
              // ---!!! 오류 수정: BuildContext_PLACEHOLDER() -> context !!!---
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
                trackHeight: 6.0,
                trackShape: const RoundedRectSliderTrackShape(),
                activeTrackColor: Colors.green,
                inactiveTrackColor: Colors.red.shade200,
                thumbColor: Colors.white,
              ),
              child: Slider(
                value: congestion,
                min: 0,
                max: maxCapacity,
                onChanged: null, // 표시용
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('쾌적', style: TextStyle(color: Colors.green)),
                  Text('혼잡', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 별점 위젯
  Widget _buildStarRating(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    double halfStar = rating - fullStars;

    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: Colors.amber, size: 20));
    }
    // 0.1~0.9 사이면 반 별
    if (halfStar >= 0.1) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 20));
    }
    // 나머지 빈 별
    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 20));
    }
    return Row(children: stars);
  }
}