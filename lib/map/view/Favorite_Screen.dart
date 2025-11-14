import 'package:flutter/material.dart';
// ---!!! import 경로를 님의 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Facility_Detail_Screen.dart'; // 시설 소개창 import

class FavoritesScreen extends StatefulWidget {
  // ---!!! [핵심] 이 페이지는 자신만의 Scaffold를 가집니다 !!!---
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // ---!!! [수정] Mock 데이터를 4개로 확장 !!!---
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
      "congestion": 37.0, // 37명 (보통)
      "maxCapacity": 100.0
    },
    {
      "name": "송파구민체육센터",
      "distance": "0.8km",
      "rating": 4.5,
      "congestion": 85.0, // 85명 (혼잡)
      "maxCapacity": 100.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 상단 앱 바 (AppBar)
      appBar: AppBar(
        // ---!!! [핵심] 중첩 네비게이터가 자동으로 '뒤로가기(<)' 버튼을 생성 !!!---
        // (Navigator.pushNamed('/favorites')로 띄워졌기 때문)
        title: TextField(
          readOnly: true, // 읽기 전용
          decoration: InputDecoration(
            hintText: '검색창 : ',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.grey[400]),
          ),
          onTap: () {
            // TODO: 검색창 탭 기능?
          },
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
                return InkWell(
                  onTap: () {
                    // ---!!! 프로토타입 연결 (C) !!!---
                    // 'Facility_Detail_Screen'을 *전체 화면*으로 띄웁니다.
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) =>
                          const FacilityDetailScreen()),
                    );
                  },
                  child: _buildFavoriteCard(
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
      // ---!!! [핵심] 하단 탭 바는 이 파일에 없습니다 !!!---
      // (부모인 Main_Screen.dart가 가지고 있습니다)
    );
  }

  // (이하 _buildFavoriteCard, _buildStarRating 및
  //  커스텀 Slider(_GradientTrackShape, _ChipThumbShape) 코드는
  //  님이 제공해주신 최신 'lib/map/view/Favorite_Screen.dart' 파일의
  //  내용과 100% 동일하게 여기에 붙여넣어야 합니다.)

  // ---!!! 헬퍼 함수들을 State 클래스 *안*으로 이동 !!!---

  // 즐겨찾기 카드 위젯
  Widget _buildFavoriteCard({
    required String name,
    required String distance,
    required double rating,
    required double congestion,
    required double maxCapacity,
  }) {
    // 혼잡도에 따른 색상 결정
    final Color congestionColor = _getCongestionColor(congestion, maxCapacity);
    // 혼잡도 텍스트 (쾌적, 보통, 혼잡)
    final String congestionText =
    _getCongestionStatus(congestion, maxCapacity);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
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
              ],
            ),
            const SizedBox(height: 12),
            // ---!!! 새로운 커스텀 슬라이더 !!!---
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 6.0,
                // 1. 커스텀 그라데이션 트랙 적용
                trackShape: const _GradientTrackShape(),
                // 2. 커스텀 칩 모양 썸(Thumb) 적용
                thumbShape: _ChipThumbShape(
                  congestion: congestion.toInt(),
                  color: congestionColor,
                ),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 0), // 물방울 효과 제거
                thumbColor: Colors.white, // (ThumbShape가 그리므로 실제론 사용 안됨)
              ),
              child: Slider(
                value: congestion,
                min: 0,
                max: maxCapacity,
                onChanged: null, // 표시용
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('쾌적', style: TextStyle(color: Colors.green.shade700)),
                  Text('혼잡', style: TextStyle(color: Colors.red.shade700)),
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
    if (halfStar >= 0.1) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 20));
    }
    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 20));
    }
    return Row(children: stars);
  }

  // ---!!! 혼잡도에 따른 색상/텍스트 반환 헬퍼 !!!---
  Color _getCongestionColor(double congestion, double maxCapacity) {
    double ratio = congestion / maxCapacity;
    if (ratio < 0.33) {
      return Colors.green.shade600; // 쾌적
    } else if (ratio < 0.66) {
      return Colors.yellow.shade700; // 보통
    } else {
      return Colors.red.shade600; // 혼잡
    }
  }

  String _getCongestionStatus(double congestion, double maxCapacity) {
    double ratio = congestion / maxCapacity;
    if (ratio < 0.33) {
      return '쾌적';
    } else if (ratio < 0.66) {
      return '보통';
    } else {
      return '혼잡';
    }
  }
}

// ---!!! 1. 그라데이션 트랙을 그리는 커스텀 클래스 !!!---
class _GradientTrackShape extends SliderTrackShape {
  const _GradientTrackShape();

  // 그라데이션 정의
  static const LinearGradient gradient = LinearGradient(
    colors: [Colors.green, Colors.yellow, Colors.red],
  );

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  // ---!!! [오류 최종 수정] !!!---
  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required Offset thumbCenter,
        Offset? secondaryOffset,
        bool isEnabled = false,
        bool isDiscrete = false,
      }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    // 그라데이션 페인트 생성
    final Paint paint = Paint()..shader = gradient.createShader(trackRect);

    // 트랙 모양 (둥근 모서리)
    final RRect trackRRect = RRect.fromRectAndRadius(
      trackRect,
      Radius.circular(sliderTheme.trackHeight! / 2),
    );

    context.canvas.drawRRect(trackRRect, paint);
  }
}

// ---!!! 2. 인원수 칩을 썸(Thumb)으로 그리는 커스텀 클래스 !!!---
class _ChipThumbShape extends SliderComponentShape {
  final int congestion;
  final Color color;

  const _ChipThumbShape({required this.congestion, required this.color});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(48, 28); // 칩의 크기
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    // 1. 칩의 배경(RRect) 그리기
    final Paint paint = Paint()..color = color;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center.translate(0, -10), width: 44, height: 24), // 썸 위로 살짝 올림
      const Radius.circular(12),
    );
    canvas.drawRRect(rrect, paint);

    // 2. 칩의 흰색 테두리 그리기
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rrect, borderPaint);

    // 3. 칩 안에 텍스트('OO명') 그리기
    final TextSpan span = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      text: '${congestion}명',
    );
    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    final Offset textOffset =
    center.translate(-tp.width / 2, -10 - tp.height / 2);
    tp.paint(canvas, textOffset);

    // 4. 슬라이더 트랙 위의 작은 흰색 원 (Thumb) 그리기
    canvas.drawCircle(center, 6, Paint()..color = Colors.white);
  }
}