import 'package:flutter/material.dart';
// ---!!! 1. Google Maps 패키지를 import 합니다 !!!---
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ---!!! import 경로를 님의 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Facility_Detail_Screen.dart';
import 'package:victor/map/view/Search_Screen.dart';

// ---!!! [수정] GoogleMap 위젯은 'StatefulWidget'이 필요합니다 !!!---
class MapMainScreen extends StatefulWidget {
  const MapMainScreen({super.key});

  @override
  State<MapMainScreen> createState() => _MapMainScreenState();
}

class _MapMainScreenState extends State<MapMainScreen> {

  // ---!!! [신규] 지도 컨트롤러와 마커 설정 !!!---
  late GoogleMapController mapController;

  // (임시) 서울 시청 위치
  final LatLng _center = const LatLng(37.5665, 126.9780);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  // ---!!! [수정 완료] ---!!!


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // 1. 상단 앱 바 (AppBar) - (이전과 동일)
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/search');
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
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),

      // 2. 메인 컨텐츠 (지도 + 시설 목록)
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---!!! [핵심 수정] Image.asset 대신 GoogleMap 위젯으로 교체 !!!---
            SizedBox(
              height: 300, // 지도의 높이
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center, // 초기 카메라 위치 (서울 시청)
                  zoom: 11.0,
                ),
                markers: { // ---!!! 마커 세트 !!!---
                  Marker(
                      markerId: const MarkerId('gangnam_center'),
                      position: const LatLng(37.4936, 127.0623), // (임의의 위치)
                      infoWindow: const InfoWindow(
                        title: '강남스포츠센터',
                        snippet: '탭하여 상세보기',
                      ),
                      onTap: () {
                        // ---!!! [핵심] 마커 탭하면 시설 소개로 이동 !!!---
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (context) => FacilityDetailScreen()),
                        );
                      }
                  )
                  // TODO: ViewModel에서 받아온 시설 목록으로 마커를 더 추가
                },
              ),
            ),
            // ---!!! [수정 완료] ---!!!

            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                '각 구별 인기 있는 시설들',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            // 2x2 격자 GridView (이전과 동일)
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
              itemCount: 4,
              itemBuilder: (context, index) {
                final List<Map<String, String>> facilities = [
                  {
                    "name": "강남스포츠센터",
                    "location": "강남구",
                    "imageUrl": "assets/AKR20240416124700060_01_i_P4.jpg"
                  },
                  {
                    "name": "서초 배드민턴장",
                    "location": "서초구",
                    "imageUrl": "assets/badminton_img0302.jpg"
                  },
                  {
                    "name": "마포구민체육센터",
                    "location": "마포구",
                    "imageUrl": "assets/cts5395_img07.jpg"
                  },
                  {
                    "name": "마포실내체육센터",
                    "location": "마포구",
                    "imageUrl": "assets/img_yongwang.jpg"
                  }
                ];
                return _buildFacilityCard(
                  context,
                  facilities[index]['name']!,
                  facilities[index]['location']!,
                  facilities[index]['imageUrl']!,
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // 카드 헬퍼 (이전과 동일)
  Widget _buildFacilityCard(
      BuildContext context, String name, String location, String imageUrl) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // '시설 소개'는 하단 탭이 필요 없으므로 'rootNavigator: true' 유지!
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) => FacilityDetailScreen()),
          );
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