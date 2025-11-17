import 'package:flutter/material.dart';
// ⭐️ 1. go_router 패키지를 import 합니다.
import 'package:go_router/go_router.dart';

// ---!!! [수정] 님의 PascalCase 파일명에 맞춤 !!!---
import 'package:victor/map/view/facility_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // ---!!! [수정] Mock 데이터에 'id' 추가 !!!---
  final List<Map<String, dynamic>> favoriteList = [
    {
      "id": "F_GANGNAM", // (임시 ID)
      "name": "강남구민체육센터",
      "distance": "1.2km",
      "rating": 4.7,
      "congestion": 10.0,
      "maxCapacity": 100.0
    },
    {
      "id": "F_JAMSIL", // (임시 ID)
      "name": "잠실종합운동장 배드민턴장",
      "distance": "2.0km",
      "rating": 4.8,
      "congestion": 23.0,
      "maxCapacity": 100.0
    },
    {
      "id": "F_MAPO1", // (임시 ID)
      "name": "마포구민체육센터",
      "distance": "1.5km",
      "rating": 4.51,
      "congestion": 37.0,
      "maxCapacity": 100.0
    },
    {
      "id": "F_SONGPA1", // (임시 ID)
      "name": "송파구민체육센터",
      "distance": "0.8km",
      "rating": 4.5,
      "congestion": 85.0,
      "maxCapacity": 100.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: '검색창 : ',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.grey[400]),
          ),
          // ⭐️ 2. [수정] 탭(홈) 내에서 '/search' 화면으로 이동
          onTap: () {
            // '/favorites'와 '/search'는 같은 '홈' 탭의 하위 경로입니다.
            context.push('/search');
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.star, color: Colors.amber),
          ),
        ],
      ),
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
                    // ⭐️ 3. [수정] Navigator.of(...) 대신 context.push() 사용
                    // 1단계에서 정의한 최상위 경로('/facility/:id')로 이동합니다.
                    // 이 경로는 셸 바깥에 있으므로 하단 탭 바를 덮고 나옵니다.
                    context.push('/facility/${item['id']}');
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
    );
  }

  // ---!!! 헬퍼 함수들은 모두 동일 (수정 X) !!!---

  // 즐겨찾기 카드 위젯
  Widget _buildFavoriteCard({
    required String name,
    required String distance,
    required double rating,
    required double congestion,
    required double maxCapacity,
  }) {
    final Color congestionColor = _getCongestionColor(congestion, maxCapacity);
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
                // ---!!! [버그 수정] '...' (spread operator) 추가 !!!---
                ..._buildStarRating(rating),
                const SizedBox(width: 8),
                Text(rating.toString(), style: const TextStyle(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 6.0,
                trackShape: const _GradientTrackShape(),
                thumbShape: _ChipThumbShape(
                  congestion: congestion.toInt(),
                  color: congestionColor,
                ),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                thumbColor: Colors.white,
              ),
              child: Slider(
                value: congestion,
                min: 0,
                max: maxCapacity,
                onChanged: null,
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

  // ---!!! [버그 수정] 'return Row(..)' -> 'return stars;' !!!---
  // 별점 위젯
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

    final Paint paint = Paint()..shader = gradient.createShader(trackRect);

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
    return const Size(48, 28);
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

    final Paint paint = Paint()..color = color;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center.translate(0, -10), width: 44, height: 24),
      const Radius.circular(12),
    );
    canvas.drawRRect(rrect, paint);

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rrect, borderPaint);

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

    canvas.drawCircle(center, 6, Paint()..color = Colors.white);
  }
}