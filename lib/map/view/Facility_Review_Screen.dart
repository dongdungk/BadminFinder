import 'package:flutter/material.dart';

class FacilityReviewScreen extends StatelessWidget {
  // ---!!! [오류 수정] 'const' 키워드 제거 !!!---
  // (final 멤버 변수들이 있으므로 const 생성자가 될 수 없습니다)
  FacilityReviewScreen({super.key});

  // --- Mock 데이터 (임시) ---
  final double averageRating = 4.51;
  final int totalReviews = 127;
  final Map<int, int> ratingPercentages = {
    5: 45,
    4: 28,
    3: 15,
    2: 8,
    1: 4,
  };
  final List<Map<String, dynamic>> reviews = [
    {
      "name": "김**",
      "date": "2024.10.15",
      "rating": 5,
      "text": "시설이 정말 깨끗하고 배드민턴 코트도 넓어요. 강사님들도 친절하시고 운동하기 좋은 환경입니다!",
      "likes": 12,
      "comments": 2,
    },
    {
      "name": "이**",
      "date": "2024.10.10",
      "rating": 4,
      "text": "역에서 가까워서 접근성이 좋습니다. 주차장도 넓어요.",
      "likes": 12,
      "comments": 2,
    },
    {
      "name": "박**",
      "date": "2024.10.05",
      "rating": 5,
      "text": "배드민턴 동호회 활동하기 딱 좋아요. 저녁 시간대도 이용 가능해서 퇴근 후 운동하기 편합니다.",
      "likes": 12,
      "comments": 2,
    }
  ];
  // -------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---!!! 1. 님이 요청하신 AppBar !!!---
      appBar: AppBar(
        title: const Text('서초구민체육센터'), // (임시) 시설 이름
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border), // 즐겨찾기 전
            onPressed: () {
              // TODO: 즐겨찾기 추가/삭제 로직
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // ---!!! 2. 님이 요청하신 평점 요약 위젯 !!!---
          _buildRatingSummary(),

          const Divider(height: 20, thickness: 8, color: Color(0xFFF5F5F5)),

          // ---!!! 3. 님이 요청하신 리뷰 목록 (아래로 이동) !!!---
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return _buildReviewCard(review);
            },
          ),
        ],
      ),
    );
  }

  // ---!!! [신규] 평점 요약 UI 위젯 ---!!!
  Widget _buildRatingSummary() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. 왼쪽: 평균 평점
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  averageRating.toString(),
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ---!!! [오류 1 수정] '...' (spread operator) 추가 !!!---
                  children: [..._buildStarRating(averageRating, size: 20)],
                ),
                const SizedBox(height: 4),
                Text(
                  '$totalReviews개 리뷰',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // 2. 오른쪽: 별점별 막대 그래프
          Expanded(
            flex: 3,
            child: Column(
              children: List.generate(5, (index) {
                final star = 5 - index; // 5, 4, 3, 2, 1 순서
                final percentage = ratingPercentages[star]!;
                return _buildRatingBarRow(star, percentage);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 평점 요약 - 막대 그래프 행 헬퍼
  Widget _buildRatingBarRow(int star, int percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text('$star', style: const TextStyle(fontSize: 13)),
          const Icon(Icons.star, color: Colors.amber, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage / 100.0, // 0.0 ~ 1.0
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$percentage%',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ---!!! [신규] 리뷰 카드 UI 위젯 ---!!!
  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 별점 + 이름 + 날짜
            Row(
              children: [
                ..._buildStarRating(review['rating'].toDouble(), size: 18),
                const SizedBox(width: 12),
                Text(
                  review['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(width: 8),
                Text(
                  review['date'],
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 2. 리뷰 텍스트
            Text(
              review['text'],
              style: const TextStyle(fontSize: 15, height: 1.4), // 줄 간격
            ),
            const SizedBox(height: 16),

            // 3. 도움돼요 / 답글
            Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined,
                    size: 16, color: Colors.grey[700]),
                const SizedBox(width: 4),
                Text(
                  '도움돼요 ${review['likes']}',
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
                const SizedBox(width: 16),
                Text(
                  '답글 ${review['comments']}',
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---!!! [오류 1 수정] 'return Row(..)' -> 'return stars;' !!!---
  // 별점 생성 헬퍼 (사이즈 조절 가능하게)
  List<Widget> _buildStarRating(double rating, {double size = 20}) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    double halfStar = rating - fullStars;

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.amber, size: size));
    }
    if (halfStar >= 0.1) {
      stars.add(Icon(Icons.star_half, color: Colors.amber, size: size));
    }
    while (stars.length < 5) {
      stars.add(Icon(Icons.star_border, color: Colors.amber, size: size));
    }
    return stars; // <-- Row()가 아닌 List<Widget>을 반환합니다.
  }
}