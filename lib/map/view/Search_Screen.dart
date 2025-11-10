import 'package:flutter/material.dart';
// ---!!! 1개의 import 경로를 실제 파일명(PascalCase)에 맞게 수정 !!!---
import 'package:victor/map/view/Facility_Detail_Screen.dart'; // 시설 소개창 import

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // 임시 검색 결과 목록
  final List<String> searchResults = [
    "서초구 시설",
    "강남구민체육센터",
    "잠실종합운동장",
    "마포구민체육센터",
    "송파구민체육관",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // TODO: 실제 검색 로직 수행 (ViewModel 호출)
            // (지금은 엔터쳐도 아무 일 없음)
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: '최근 검색어' 또는 '관련 검색어' UI 추가

          // 검색 결과 목록
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final result = searchResults[index];
                return ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(result),
                  onTap: () {
                    // ---!!! 프로토타Myp 연결 (C) !!!---
                    // 검색 결과(예: 서초구 시설)를 탭하면 '시설 소개창'으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FacilityDetailScreen()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}