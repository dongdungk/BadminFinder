// lib/map/view/map_main_screen.dart

// lib/map/view/map_main_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// ⭐️ [수정] LoginViewModel 경로: lib/map/view/ 에서 '../../login/viewmodel/'로 이동
import '../../login/viewmodel/login_viewmodel.dart';


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

  // ---!!! [최종] GridView에서 사용할 API 일치 시설 목록 !!!---
  final List<Map<String, String>> facilities = [
    {
      "id": "월곡배드민턴장", // 👈 API 시설명
      "name": "월곡배드민턴장",
      "location": "성북구",
      "imageUrl": "assets/AKR20240416124700060_01_i_P4.jpg"
    },
    {
      "id": "매봉산실내배드민턴장", // 👈 API 시설명
      "name": "매봉산실내배드민턴장",
      "location": "강남구",
      "imageUrl": "assets/badminton_img0302.jpg"
    },
    {
      "id": "마곡레포츠센터 실내배드민턴장", // 👈 API 시설명
      "name": "마곡레포츠센터 실내배드민턴장",
      "location": "강서구",
      "imageUrl": "assets/cts5395_img07.jpg"
    },
    {
      "id": "금화배드민턴장", // 👈 API 시설명
      "name": "금화배드민턴장",
      "location": "서대문구",
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
          //⭐️ [로그아웃 버튼]
          IconButton(
           icon: const Icon(Icons.logout, color: Colors.black),
          onPressed: () async {
           await context.read<LoginViewModel>().signOut();
           if (!context.mounted) return; // 위젯이 마운트된 상태인지 확인
          context.go('/login');
          },
          ),
          IconButton(
            icon: const Icon(Icons.star_border, color: Colors.black),
            onPressed: () {
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
                        context.push('/facility/강남스포츠센터');
                      })
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
              itemCount: facilities.length,
              itemBuilder: (context, index) {
                final facility = facilities[index];
                return _buildFacilityCard(
                  context,
                  facility['id']!, // API 시설명 (예: 월곡배드민턴장)
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

  Widget _buildFacilityCard(BuildContext context, String id, String name,
      String location, String imageUrl) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // ID(시설명)을 상세 페이지로 전달
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