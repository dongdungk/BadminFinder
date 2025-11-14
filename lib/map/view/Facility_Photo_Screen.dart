import 'package:flutter/material.dart';

// ---!!! [수정] StatefulWidget으로 변경 (필터 칩 상태 관리를 위해) !!!---
class FacilityPhotoScreen extends StatefulWidget {
  const FacilityPhotoScreen({super.key});

  @override
  State<FacilityPhotoScreen> createState() => _FacilityPhotoScreenState();
}

class _FacilityPhotoScreenState extends State<FacilityPhotoScreen> {
  int _selectedChipIndex = 0; // '전체' 칩이 기본 선택

  // ---!!! [신규] 님이 assets에 추가하신 12개의 이미지 리스트 !!!---
  final List<String> photoAssets = [
    "assets/download.jpg",
    "assets/download1.jpg",
    "assets/images.jpg",
    "assets/images (1).jpg",
    "assets/images (2).jpg",
    "assets/images (3).jpg",
    "assets/images (4).jpg",
    "assets/images (5).jpg",
    "assets/AKR20240416124700060_01_i_P4.jpg",
    "assets/AKR20240416124700060_01_i_P4.jpg",
    "assets/cts5395_img07.jpg",
    "assets/img_yongwang.jpg"

    // (assets 폴더에 사진이 더 있다면 여기에 추가하세요)
  ];

  final List<String> filterChips = [
    '전체',
    '클립',
    '방문자',
    '블로그',
    '인스타'
  ];

  @override
  Widget build(BuildContext context) {
    // ---!!! [수정] Scaffold와 AppBar 추가 !!!---
    return Scaffold(
      // 1. 님이 요청하신 AppBar (시설 이름 + 즐겨찾기)
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
      // ---!!! [수정] ListView로 변경하여 전체 스크롤 !!!---
      body: ListView(
        children: [
          // 2. 님이 요청하신 '사진 256장' 배너
          _buildUploadBanner(),

          // 3. 님이 요청하신 필터 칩
          _buildFilterChips(),

          // 4. 사진 그리드
          GridView.builder(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true, // ListView 안에서 스크롤 충돌 방지
            physics: const NeverScrollableScrollPhysics(), // ListView가 스크롤
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 한 줄에 3개
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            // ---!!! [수정] 님의 assets 이미지 개수만큼 !!!---
            itemCount: photoAssets.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // 이미지 모서리 둥글게
                // ---!!! [수정] Image.asset() 사용 !!!---
                child: Image.asset(
                  photoAssets[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Icon(Icons.error_outline, color: Colors.grey),
                    );
                  },
                ),
              );
            },
          ),

          // 5. 님이 요청하신 '사진 더보기' 버튼
          _buildShowMoreButton(),
        ],
      ),
    );
  }

  // ---!!! [신규] '사진 256장' 배너 헬퍼 ---!!!
  Widget _buildUploadBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05), // 옅은 파란색 배경
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.camera_alt_outlined, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  '사진 256장', // (임시)
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: 사진 올리기 기능
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('사진 올리기'),
            ),
          ],
        ),
      ),
    );
  }

  // ---!!! [신규] 필터 칩 헬퍼 ---!!!
  Widget _buildFilterChips() {
    return SizedBox(
      height: 60.0, // 칩 리스트의 높이
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: filterChips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(filterChips[index]),
              selected: _selectedChipIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  _selectedChipIndex = selected ? index : -1;
                  // TODO: ViewModel을 통해 필터링 로직 수행
                });
              },
              selectedColor: Colors.blue, // 선택됐을 때 색상
              labelStyle: TextStyle(
                color: _selectedChipIndex == index ? Colors.white : Colors.black,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: _selectedChipIndex == index
                      ? Colors.blue
                      : Colors.grey.shade300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---!!! [신규] '사진 더보기' 버튼 헬퍼 ---!!!
  Widget _buildShowMoreButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlinedButton(
        onPressed: () {
          // TODO: 사진 더보기 (페이지네이션)
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), // 버튼 높이 50
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: const Text(
          '사진 더보기 (244장)', // (임시)
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}