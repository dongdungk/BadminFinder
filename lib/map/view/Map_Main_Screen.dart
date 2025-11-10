import 'package:flutter/material.dart';
// ---!!! 2개의 import 경로를 님의 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Facility_Detail_Screen.dart'; // PascalCase
import 'package:victor/map/view/Search_Screen.dart'; // PascalCase

class MapMainScreen extends StatelessWidget {
  // Main_Screen의 'body'로 사용될 것이므로, Stateful이 아니어도 됨.
  const MapMainScreen({super.key});

  // ---!!! '알맹이'만 반환합니다. (Scaffold, AppBar 없음) !!!---
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2-1. 지도 영역 (임시)
          GestureDetector(
            onTap: () {
              // ---!!! 프로토타입 연결 (B) !!!---
              // (임시) 지도를 탭하면 '시설 소개창'으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FacilityDetailScreen()),
              );
            },
            child: Container(
              height: 400,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Text(
                'Google Map API 연동 영역\n(지도 마커를 탭하면 시설 소개창으로 이동)\n\n(지금은 이 회색 영역 아무데나 탭하세요)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),

          // 2-2. '각 구별 인기 있는 시설들' 타이틀
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              '각 구별 인기 있는 시설들',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // 2-3. 인기 시설 가로 스크롤 리스트
          SizedBox(
            height: 220, // 카드 높이
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              itemCount: 5, // 임시로 5개
              itemBuilder: (context, index) {
                return _buildFacilityCard(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 임시 시설 카드 위젯
  Widget _buildFacilityCard(BuildContext context, int index) {
    return SizedBox(
      width: 200, // 카드 너비
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell( // 탭 가능하도록 InkWell 추가
          onTap: () {
            // ---!!! 프로토타입 연결 (B) !!!---
            // 인기 시설 카드를 탭하면 '시설 소개창'으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FacilityDetailScreen()),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                alignment: Alignment.center,
                child: Text(
                  '시설 이미지 ${index + 1}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '시설 이름 ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '시설 위치 (예: 강남구)',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}