import 'package:flutter/material.dart';
// ⭐️ 1. [수정] go_router 패키지를 import 합니다.
import 'package:go_router/go_router.dart';

// ---!!! [수정] 님의 PascalCase 파일명에 맞춤 !!!---
import 'package:victor/map/view/facility_detail_screen.dart';
import 'package:victor/map/view/search_screen.dart';
// ---!!! [신규] Google Maps 임포트 !!!---
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMainScreen extends StatefulWidget {
  const MapMainScreen({super.key});

  @override
  State<MapMainScreen> createState() => _MapMainScreenState();
}

class _MapMainScreenState extends State<MapMainScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.5665, 126.9780); // 서울 시청

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // ---!!! [수정] GridView에서 사용할 4개의 시설 (임시 ID 추가) !!!---
  final List<Map<String, String>> facilities = [
    {
      "id": "M_GANGNAM", // (임시 ID)
      "name": "강남스포츠센터",
      "location": "강남구",
      "imageUrl": "assets/AKR20240416124700060_01_i_P4.jpg"
    },
    {
      "id": "M_SEOCHO", // (임시 ID)
      "name": "서초 배드민턴장",
      "location": "서초구",
      "imageUrl": "assets/badminton_img0302.jpg"
    },
    {
      "id": "M_MAPO1", // (임시 ID)
      "name": "마포구민체육센터",
      "location": "마포구",
      "imageUrl": "assets/cts5395_img07.jpg"
    },
    {
      "id": "M_MAPO2", // (임시 ID)
      "name": "마포실내체육센터",
      "location": "마포구",
      "imageUrl": "assets/img_yongwang.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            // ⭐️ 2. [수정] Navigator.pushNamed -> context.push
            // '/search'는 '/' (홈 탭)의 하위 경로입니다.
            context.push('/search');
          },
          child: Container(
            color: Colors.transparent,
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: '검색창 : ',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey[400]),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border, color: Colors.black),
            onPressed: () {
              // ⭐️ 3. [수정] Navigator.pushNamed -> context.push
              // '/favorites'는 '/' (홈 탭)의 하위 경로입니다.
              context.push('/favorites');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: {
                  Marker(
                      markerId: const MarkerId('gangnam_center'),
                      position: const LatLng(37.4936, 127.0623),
                      infoWindow: const InfoWindow(
                        title: '강남스포츠센터',
                        snippet: '탭하여 상세보기',
                      ),
                      onTap: () {
                        // ⭐️ 4. [수정] Navigator.of(...) -> context.push
                        // 최상위 경로('/facility/:id')로 이동 (탭 바 덮음)
                        context.push('/facility/M_GANGNAM');
                      })
                  // TODO: ViewModel에서 마커 추가
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                '각 구별 인기 있는 시설들',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: facilities.length, // 4개
              itemBuilder: (context, index) {
                final facility = facilities[index];
                return _buildFacilityCard(
                  context,
                  facility['id']!, // 1. ID 전달
                  facility['name']!,
                  facility['location']!,
                  facility['imageUrl']!,
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ---!!! [수정] 헬퍼 함수가 'id'도 받도록 수정 !!!---
  Widget _buildFacilityCard(BuildContext context, String id, String name,
      String location, String imageUrl) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // ⭐️ 5. [수정] Navigator.of(...) -> context.push
          // 최상위 경로('/facility/:id')로 이동 (탭 바 덮음)
          context.push('/facility/$id');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: const Icon(Icons.error_outline, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}