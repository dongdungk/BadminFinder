import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Google Maps 임포트
// ---!!! import 경로를 님의 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Main_Screen.dart'; // mainNavigatorKey 임포트

class TaggingMainScreen extends StatefulWidget {
  // ---!!! [핵심] 이 페이지는 자신만의 Scaffold를 가집니다 !!!---
  const TaggingMainScreen({super.key});

  @override
  State<TaggingMainScreen> createState() => _TaggingMainScreenState();
}

class _TaggingMainScreenState extends State<TaggingMainScreen> {
  // ---!!! [신규] '충족조건O' / '충족조건X' 상태를 관리하는 변수 !!!---
  bool _isConditionMet = false; // false = 충족조건X, true = 충족조건O

  // --- 지도 관련 변수 ---
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.4949, 127.0142); // (임시) 서초구민체육센터 위치
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // (임시) '내 위치' 마커
    _markers.add(
      Marker(
        markerId: const MarkerId('myLocation'),
        position: _center, // (임시) '내 위치'도 센터와 동일하게 설정
        infoWindow: const InfoWindow(title: '내 위치'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---!!! [수정] 하단 탭이 가려지는 문제 해결 !!!---
      resizeToAvoidBottomInset: false,

      // 1. 상단 앱 바 (AppBar)
      appBar: AppBar(
        // '뒤로가기' 버튼이 자동으로 생성됩니다. (중첩 네비게이터)
        title: const Text('서초구민체육센터'), // (임시)
        actions: [
          IconButton(
            icon: const Icon(Icons.mic_none),
            onPressed: () {
              // TODO: 음성 검색
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context); // '뒤로가기'와 동일
            },
          ),
        ],
      ),

      // 2. 메인 컨텐츠 (지도 + 하단 시트)
      body: Stack(
        children: [
          // 2-1. Google 지도
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 16.0,
            ),
            markers: _markers,
            myLocationButtonEnabled: false, // '내 위치' 버튼 (오른쪽 위)
            myLocationEnabled: true, // 파란색 '내 위치' 점 표시
          ),

          // 2-2. 지도 위 오버레이 버튼들 (내 위치, 즐겨찾기 등)
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                // (피그마 시안의 오른쪽 버튼들)
                FloatingActionButton(
                  heroTag: 'btn1', // Hero 태그 중복 방지
                  mini: true,
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.map_outlined, color: Colors.black),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'btn2',
                  mini: true,
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.star_border, color: Colors.black),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'btn3',
                  mini: true,
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.my_location, color: Colors.black),
                ),
              ],
            ),
          ),

          // 2-3. '범위 외/내' 칩
          Positioned(
            top: 16,
            left: 16,
            child: Chip(
              label: Text(_isConditionMet ? '범위 내' : '범위 외'),
              backgroundColor:
              _isConditionMet ? Colors.blue.shade100 : Colors.grey.shade300,
              avatar: Icon(
                Icons.wifi_tethering,
                color: _isConditionMet ? Colors.blue : Colors.grey,
              ),
            ),
          ),

          // 2-4. 하단 고정 시트 (DraggableScrollableSheet)
          // (간단하게 Container로 대체합니다)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---!!! [핵심] 상태에 따라 다른 UI 표시 !!!---
                    _isConditionMet
                        ? _buildConditionMetContent(context) // 충족조건O
                        : _buildConditionNotMetContent(context), // 충족조건X
                  ],
                ),
              ),
            ),
          ),

          // ---!!! (임시) 상태 전환 테스트용 버튼 !!!---
          Positioned(
            bottom: 250, // (하단 시트 위)
            right: 16,
            child: FloatingActionButton(
              heroTag: 'btn4',
              onPressed: () {
                setState(() {
                  _isConditionMet = !_isConditionMet; // 상태를 반전
                });
              },
              child: const Icon(Icons.swap_horiz),
            ),
          ),
        ],
      ),
      // ---!!! [핵심] 하단 탭 바는 이 파일에 없습니다 !!!---
      // (부모인 Main_Screen.dart가 가지고 있습니다)
    );
  }

  // ---!!! [신규] '충족조건X' (image_73e91f.jpg) 하단 시트 UI ---!!!
  Widget _buildConditionNotMetContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '체크인 조건',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text('• 배드민턴장 반경 100m 이내에 있어야 합니다.'),
        const SizedBox(height: 8),
        const Text('• 위치 서비스가 활성화되어 있어야 합니다.'),
        const SizedBox(height: 8),
        const Text('• 즐겨찾기에서 근처 체육관을 확인하세요.'),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        // 하단 '가까운 체육관' 카드
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '서초구민체육센터',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[100],
            foregroundColor: Colors.black,
            elevation: 0,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {},
          child: const Text('가장 가까운 체육관까지 약 325m'),
        ),
        const SizedBox(height: 8),
        // Check in (비활성화)
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300], // 비활성화 색
            foregroundColor: Colors.grey[600],
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: null, // 비활성화
          child: const Text('Check In 불가'),
        ),
      ],
    );
  }

  // ---!!! [신규] '충족조건O' (image_73e959.jpg) 하단 시트 UI ---!!!
  Widget _buildConditionMetContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '이용 안내',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text('• 배드민턴장 입구의 태그를 스캔해주세요.'),
        const SizedBox(height: 8),
        const Text('• 태깅 시 자동으로 방문기록이 저장됩니다.'),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        // 하단 '체육관' 카드
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '서초구민체육센터',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Check In (활성화)
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // 활성화 색
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            // ---!!! [핵심] '태그 성공' 화면으로 이동 !!!---
            // (하단 탭이 계속 보여야 하므로, rootNavigator: false)
            Navigator.pushNamed(context, '/tagging_success');
          },
          child: const Text('Check In'),
        ),
      ],
    );
  }
}